Return-Path: <linux-pm+bounces-21223-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B3BA24F16
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 18:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65EAD188301D
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 17:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90411F428F;
	Sun,  2 Feb 2025 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWi+AfFH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832641FB3
	for <linux-pm@vger.kernel.org>; Sun,  2 Feb 2025 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738516375; cv=none; b=eYIZhiTgPQAqBgK9X4Cxhi2/z+05Ce4+h6fr7cJH4bBBqg1JWKvfI9CQjIW0iibESa+zC5L+uC9fer2DJg2AJ40JPI1KVqN+Blh4LanpBz6m/ciG1xLy+wdG6cLp9eMygE6BQvV2cq38fhnsBzUc6QSspUlpj/YULTzrqEGvR0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738516375; c=relaxed/simple;
	bh=kmK8bsto94k9YZPmqyJk/ShhrsrS1t5kv/KdYyUvQGg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QNn14g8L/vTlFFX3W2zyWSnUQhKuQvkHDESfE5hh1PLxatc1wUf5RgVcZN7rC/jyuqWKPCdTXn8ZTrkNzDYp9wqaVqtiQOsw2BSevPGDyz0+Qn1gVhy7ZDmtE7Sd1yXi+k2hlS+w7qUvFl0odY+mIG3AUuUKZlxkXD9og+t/4tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWi+AfFH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E1BC4CED1
	for <linux-pm@vger.kernel.org>; Sun,  2 Feb 2025 17:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738516374;
	bh=kmK8bsto94k9YZPmqyJk/ShhrsrS1t5kv/KdYyUvQGg=;
	h=From:To:Subject:Date:From;
	b=aWi+AfFHoG5BEPnQsIPkrGpMT034Weh8suBgO0qkZ7OTUUQ9A7z9h/CbBhsTCTn6p
	 vnguA8HV7AA2s159VK99e3l/BUi99TVZ3yGhy7u/+TbIuOVP3XWsjHsMYGBxwx+Vu5
	 zQpM9BzzqMuk9k6pFBoGpV2NZWK7h6RDOT3R/G9MpF07O8O9kUesjVbZdNI2lLQOMg
	 bZvh2MdHVf4ZaB7wEuCqnVPfx8dSKGzoFefuI1WdB2gDapLXggWLgnAZjcY6621BeL
	 1ghgJ67gwHJk4+q9PJXLXPvszxOMSHESikNBG4qn4JP2RkvB022tfmmoRtbBx616FC
	 lZfADGx6Zum3g==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Subject: [PATCH 0/25] turbostat-2025.0202 for linux-6.14
Date: Sun,  2 Feb 2025 11:09:16 -0600
Message-ID: <20250202171249.402610-1-lenb@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Summary of Changes since 2024.11.30:
    
    Fix regression in 2023.11.07 that affinitized forked child
    in one-shot mode.
    
    Harden one-shot mode against hotplug online/offline
    
    Enable RAPL SysWatt column by default.
    
    Add initial PTL, CWF platform support.
    
    Harden initial PMT code in response to early use.
    
    Enable first built-in PMT counter: CWF c1e residency
    
    Refuse to run on unsupported platforms without --force,
    to encourage updating to a version that supports the system,
    and to avoid no-so-useful measurement results.

As always, please let me know if you have any troubles with turbostat!

thanks,
-Len


