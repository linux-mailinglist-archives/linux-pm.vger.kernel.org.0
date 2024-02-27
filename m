Return-Path: <linux-pm+bounces-4471-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 786B986A0B4
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 21:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FC4C1F21D94
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 20:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6A614A4C9;
	Tue, 27 Feb 2024 20:16:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EB34D5A2
	for <linux-pm@vger.kernel.org>; Tue, 27 Feb 2024 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709064991; cv=none; b=G1f3ehj44ODAbljp0NVAx+ljKWtd7u8fKODlW+LOCvFQyFmjzcBHvozYNC2csg7FDWdU2EvSe6pxKRbkmGHWC4erLmMcYbPQbwFYD4gF+U5KrRyQEslISDnWEypqGJJIKnCoiwOUjCNqB1IuogsOLZSR2i+70LwRpe6PUelMX7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709064991; c=relaxed/simple;
	bh=ROvvWcIydy7YFosJO6S/oGTSdhHqLnjBhtmOqTacDm4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fJM97eI0n0X71eZ0bmptavC3RYpf6Dzi9aZblBasLSLcaEsdBwXuzLHD/CaoTXcAuAGGvl/FhVzQOaUFrFRM1xQzaFqFNPjs3AwrTbvYlG8moqjJV6HcntAfetkt0Uw7a5HAxwOL8YVYHYSyAtGI22W/mmqgBya96zF9YPRvTMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E270C433C7;
	Tue, 27 Feb 2024 20:16:30 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 768A110606FE; Tue, 27 Feb 2024 21:16:25 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, linux-pm@vger.kernel.org, 
 "Sicelo A. Mhlongo" <absicsz@gmail.com>
Cc: maemo-leste@lists.dyne.org, pali@kernel.org
In-Reply-To: <20240226193722.2173624-1-absicsz@gmail.com>
References: <20240226193722.2173624-1-absicsz@gmail.com>
Subject: Re: [PATCH] power: supply: bq27xxx: Report charge full state
 correctly
Message-Id: <170906498545.2087024.8298691569275613647.b4-ty@collabora.com>
Date: Tue, 27 Feb 2024 21:16:25 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 26 Feb 2024 21:37:22 +0200, Sicelo A. Mhlongo wrote:
> When reporting the charging status, the existing code reports the battery
> as full only when the reported current flowing is exactly 0mA, which is
> unlikely in practice.
> 
> Fix the reporting by giving priority to the battery's full state
> indication/flag.
> 
> [...]

Applied, thanks!

[1/1] power: supply: bq27xxx: Report charge full state correctly
      commit: 8fbb11162504f2de167a8ccd2d2c55a849d2c5ea

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


