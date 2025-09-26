Return-Path: <linux-pm+bounces-35487-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BA7BA4AFB
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 18:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2201C205BD
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 16:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3ED12FFF82;
	Fri, 26 Sep 2025 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqSnljLF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1EA2FF15E;
	Fri, 26 Sep 2025 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904903; cv=none; b=GVmp6NBAyZKyxz9m/xkGuv/LwA3h5YaIYUyeeHYGQ6Ble493ancFQWuE2BUXP61MG7fXk/geMymKiI/1oBZTyoVRsH1IjA/uAu+ZXrmPkJArXOqcWp1e9I93G8SNwgUedXVeJa9PfyJXIAE7ZHomZdAMgU7lK0DhSIRdwJ6gvGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904903; c=relaxed/simple;
	bh=sIQb1psRMyrYgBpUcxTNkgQoDdrxh0AoWgTE8MqeSuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E7dIfbBfPKdB7l4mdVnqqpmIkC41dBShuO+Jht8ZkhXLVdBOodwkT3wWZ2s5Z7I9NOBtr6/6w6Lh4LRQkWNThPJ8iylgWs2hlbpeopewq7Lw/4UgOCrABKuGH1Zu44Z+CadR8X9I/MKsy8Z0rS7w0ihdm0CNxu1ZhIr+p9wo/3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqSnljLF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B5EC4CEF7;
	Fri, 26 Sep 2025 16:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758904903;
	bh=sIQb1psRMyrYgBpUcxTNkgQoDdrxh0AoWgTE8MqeSuM=;
	h=From:To:Cc:Subject:Date:From;
	b=CqSnljLFo+f1++hp6Y782Qnl/XwJiA7TUnHWi5JdGSHKEqUJkW938yQKEeLKEcvml
	 NeUKNTzGOFbiWriCif2PRIFlF9N8IZo0CrWm7OOIeb0tLckOTZwaakp0SV5HY3jnjv
	 FHJQTM3CI3aZIcOB/5TAgPg3z2ICXVHdqbbSpXiYY1J9oHIQWi9/oLsMAb4bYam3h1
	 gXYGQ+ONGHjFV6J705s8BzX+xoBCSBnqpSGWMh5VlNmTx1bN82+u3BDSRDGAAks+aw
	 PAWIdeNxL+6i7AVBWGffaLOPYcwI6rZ+FahWQdrMQN2NZsAU6NQ1gnLLS63WJ0iYdI
	 dvIkgDjp/Xoiw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject:
 [PATCH v1 0/2] PM: hibernate: Fix GFP mask restoration issue and consolidate
 code
Date: Fri, 26 Sep 2025 18:37:27 +0200
Message-ID: <3303305.5fSG56mABF@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

Unfortunately, there is another issue related to the pm_restrict_gfp_mask() and
pm_restore_gfp_mask() calls that needs to be addressed (patch [1/2]) and on
top of that, some code in power_down() can be consolidated to avoid duplication
and improve clarity (patch [2/2]).

Thanks!




