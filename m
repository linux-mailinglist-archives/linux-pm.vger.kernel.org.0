Return-Path: <linux-pm+bounces-39237-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B1ACA7128
	for <lists+linux-pm@lfdr.de>; Fri, 05 Dec 2025 11:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F118A36ABF31
	for <lists+linux-pm@lfdr.de>; Fri,  5 Dec 2025 08:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61C42F7AA9;
	Fri,  5 Dec 2025 08:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHj5Chww"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5609D2F549A
	for <linux-pm@vger.kernel.org>; Fri,  5 Dec 2025 08:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764923453; cv=none; b=pg1z8MC6qEEdEX34BY1a/UaS/qBL/SlXB0VA9wd0r9C7pp3xSJQkPVzElRCnZEp6g2zedStpGzvH2lS5Z47o7/XivMe+L44Ztjkp+7T7icFvZ23cLh3/e0W//jryRCm+KIEXZEyBov9m+NxBdg4oSeUPPSXUtiE5z5VBAbu2Blo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764923453; c=relaxed/simple;
	bh=/HKbrueeav0hfVFCXbRIEc+ezn+SuJvusACsWP8Bipg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e8bsfNgy576mjOpQjUj7OulW8EdbsCTFhP7ZHtONaAHQEE/WeXu0O5J7/Y6gLVW43CtYeu3dx9K9/DH+0cfny8+fgXQIYZq9jx7dlwn0fyUwlLPiWT4pwg5nL28wqwUmonZ7867/SXCsl6Kf2qFQypIfcVAipRcAhBuoD9Xsr3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHj5Chww; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64149f78c0dso2679864a12.3
        for <linux-pm@vger.kernel.org>; Fri, 05 Dec 2025 00:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764923445; x=1765528245; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V+dVo2JNAn7MsrQQRK8VE52kJO6dog4ObFIZQRBPJw8=;
        b=FHj5Chww/xTk1hudNMq+l3Yg2nCR1m4Zfb/RxXjJuAwi+kUxlPdj1Jeu90bX7j9zHq
         OsQYyHSiBwBFGUAOmYBCoTPm1yuP7NcslWC975lwEJ1bqiAZdWt2TphMnzmJvrU+tFTF
         cGc6QBjhF6MnjOM3xSw2sfKiigr/4sk0yvecOGAtDfWNIWmVEM6P+hCddnwQwI0ezzEd
         O32JxbthsLnvFIkKPBVFQjSONP54FTdpJE8Wwb5YmU1BIlwK8Eq5nIHJ5z2LxNCG8NRN
         Pgt2yLktB/HIAipqB+raTFVZJ4FT//W60o+udsRdy7/pOSMsqYn/2AdEO0Miy1ngyobP
         Z5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764923445; x=1765528245;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+dVo2JNAn7MsrQQRK8VE52kJO6dog4ObFIZQRBPJw8=;
        b=WLoa2w/pTc5DtQCb5ZJdFqqU0bwhgeGiinrgya9OddjtX5E26AzbXRQ/0BcAEiy0Gt
         VJ4yqIw0J0h2ijFSqoIXuSwIKRM7KzKcvdNFybHX9dRwVyUCrBDJe6vIkbKKkgzq1FnS
         4RIp0p9QpmJ5HowJorKcaM12bxq3eAumQ4RFDDtseilAV/6bsBDq3PSiX0yHN6Uh2m5E
         sRMwFCpvgJtkTXhlYCJR2rphyI47ferfoMOxeEBHWnidUA2S4OotijZlU9UAzy+etQXk
         dt4WNpSMnnEmyHws38zfK8R+CKn9uuMp+Hao0Eg6BVP2dIo6FKqQVBZkx89BIGFrYhbo
         Hpaw==
X-Forwarded-Encrypted: i=1; AJvYcCXLwiwc65R0Mazf4stEmaV6cOtr6VZfRqRZ2OeA+nFERx0Jr8NC1q56OTueDMvoMmyW9N7j5Y+7vA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAk8OwZ1F3ljG35zcgiIz3zNQM8Py6JjuNXU66zh523KPonoOQ
	XJ10teXgFsVPLWAkonsVEPxzgcWKh8LyVcsMSh+BNklqD7aIfmMEELhB4oA7DMU7hOVB8Eb/I6q
	OyaTYE81AbHWCsapCm8LQhxCa/Ohq8C4=
X-Gm-Gg: ASbGnctT3OWf/FVWE+2EvkCYoWN3JCPXLTkmxAHINzmB+5M7d05mof5Cep+5PAAzU+Z
	himGCzJTi4Q73Sef+4YBL2DE1jNJyiHKaoMSCpMesUBSLHsAy0kLQeM60Ce+mk/6vgZ9SzeJ4S0
	LHAuKyQVznIM1Z3ddkLL3EH2oxpli3PBrGfYGktpsP5qKHmp3SP/VpMLR5dB+48uwLw2HnUbPhF
	xla/RoOGa9H2gPoUTmHD/VNMeJLtDVvvqy8Gy71FR4d7399X5m8Yrnx4qtLr+vQmeGR2g==
X-Google-Smtp-Source: AGHT+IHyhPhO5ji1Udtkp6jlBiDNdS1nJUTysDiG/BFsQGzVGkOYuq8S0+wdBeVac/yGVlo5iFM2k5xQ7B6Gl1w0/Sw=
X-Received: by 2002:a17:907:3fa1:b0:b76:5b73:75fb with SMTP id
 a640c23a62f3a-b79dbe72a9emr795463366b.9.1764923445456; Fri, 05 Dec 2025
 00:30:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813131007.343402-1-linux.amoon@gmail.com>
In-Reply-To: <20250813131007.343402-1-linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 5 Dec 2025 14:00:29 +0530
X-Gm-Features: AQt7F2qxbYSQuCXsYlo3s2RghAVsnJFzDr1A7ezZUPavGedOu8ugG3TEr0d0Qp4
Message-ID: <CANAwSgRqFsRvCzrK7NXfqa91xhQLLVU_u2irLBBrRcpiK9gGkA@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] Exynos Thermal code improvement
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, 
	"open list:SAMSUNG THERMAL DRIVER" <linux-pm@vger.kernel.org>, 
	"open list:SAMSUNG THERMAL DRIVER" <linux-samsung-soc@vger.kernel.org>, 
	"moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Cc: Mateusz Majewski <m.majewski2@samsung.com>
Content-Type: text/plain; charset="UTF-8"

Hi All,

On Wed, 13 Aug 2025 at 18:40, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi All,
>
> This patch series is a rework of my previous patch series [1],
> where the code changes were not adequately justified.
>
> In this new series, I have improved the commit subject
> and commit message to better explain the changes.
>
> v7: Integrated my RFC patch which improves the IRQ framework
>     for all the SoC link below.
>     [6] https://lore.kernel.org/all/20250616163831.8138-1-linux.amoon@gmail.com/
>
> v6: Add new patch to use devm_clk_get_enabled
>     and Fix few typo in subject as suggested by Daniel.
> v5: Drop the guard mutex patch
> v4: Tried to address Lukasz review comments.
>
> I dont have any Arm64 device the test and verify
> Tested on 32 bit Arch Odroid U3 amd XU4 SoC boards.
> Build with clang with W=1 enable.
>
> Please sare the feedback on this.

Can you review the first 5 patches of this series?
Do you want me to resend

Thanks
-Anand

