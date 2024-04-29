Return-Path: <linux-pm+bounces-7300-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5968B65C1
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2024 00:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A0C5B214AF
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2024 22:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE921194C78;
	Mon, 29 Apr 2024 22:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xi2F+G76"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CCD2209F
	for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2024 22:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714429845; cv=none; b=umivc+Ax32ZJfoOICRLLoEfPBs3ZZk1TJRyYTIcP01pLSmhwqenMaJ0MevIkliNWSFduAkozK5JggHa6Be2/6jZM2bTVtDliIEvNgFOAcOp20ZFUecIXJpPyHOtj5fIGYMgvHdCfmBsI4F0Ae4cAGzFQ9bXcaRa+ZAdixlCB0pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714429845; c=relaxed/simple;
	bh=1zVdJ2KsLPJPb8/4DKVEbSpiWUOAoDh1TfYhyjNb7Rs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=nDeljuy82cKdrjuIlNY3X4BNyaHaSEdnHiSWjPs+FIZmWkypLAbiUt6fylPt+pmaLjKbE/IQ+jnXjqS4RqzBlogg7tCBZHuCqhFbOZmInSw1kM9tQkF51/v6aSIouEo00GKMPct8bGh5881WEhKgGoHSCRadmLHR/uVntlvHHvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xi2F+G76; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34d7b0dac54so79564f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2024 15:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714429841; x=1715034641; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fi+PA/pQ7WrYDiqEv55H3Awp9wh4xg72V3MGQo82ow=;
        b=Xi2F+G76ad4gT3tw6TexWUb1ylyAwC0odzVGCYNsSFvDHpraF1INRwtj2iOjWhAdbT
         Rl6E+xTPdOv8GOS6azet95HaZxpK6/W/YG8C0G4SFvD1HDAYlJsJ9c6WKjCw0C9laoom
         BOdZL9TJbgfoAoGm0J0ZsH8NrRhh2m4gKYKJJE7ke98lGQUispAfE8CHPGPrDRWXBO7N
         qXvx9nBafUm+0JmhMv26sv6FACbrP5LuZTHPF9SB+lkD4ZZvdod8lbfXYOVbt1V5qco9
         iKrClfvNUetAgUsU3zx49Mbv5RuiKYZ+zj1YhEya9etvewmnT0kvQSTWnDvPZ+T4ij/l
         7Ryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714429841; x=1715034641;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7fi+PA/pQ7WrYDiqEv55H3Awp9wh4xg72V3MGQo82ow=;
        b=sVOrjxiIfU8nh+xPh59A0vAO/1G+e91L8LIGaNy3Y8m7rZEVPt4jH6sgEGkPgggZdV
         sNvlx+NmCa3iPo7Nxyzr/0ROtZrxpmRxObmA8m3kLSctm7YPGM2TIh9/G/iBjkue5uVR
         8toRIy7LZc6Z48eDk2wQys0Th2QIuIfDekW0p5y6oOF+2ZoUPITwxSW2IYTCLjlUiHTO
         gcz10Cb7ysVmAQFcJnKeqgcJ85SIrvcHpjGkk6+L1Q9zXZWXgvto3+MzTH8uME7vhq5Y
         NAaKSAeQGlOGIJJCUaUfagxRRt0EXUaMnqkpYgMNoR5UypPl5Y0+Ixp0Jkjjd2VDa8Qt
         fodA==
X-Forwarded-Encrypted: i=1; AJvYcCXXaWhuXNFaoShl317Ry3kh5ypzrnqL8zqsAI/QjZ+f6BbVcthxHRCiQYDpuWeyZPSRdpH+Wi/Q78LCnD6pc2kYTETqYtJIGnc=
X-Gm-Message-State: AOJu0YwQHUf769hAdrJILG9rIcpj0dkWHPnjNTyU5BkJGiVWVv6YRyHm
	2zuxHsmFXme53Kb+L6PVPS6+XWQkgGRgn2c/P0m+akX0CqdOclPk7/0eoO020SQ=
X-Google-Smtp-Source: AGHT+IGnxGNu62EBTl6fRvD1XJEbKx26SE74bwc01QhtcFNA7vNYYwSN/K2doKs8XhuNAGTSrlw79w==
X-Received: by 2002:a5d:4d8e:0:b0:34d:191f:6b83 with SMTP id b14-20020a5d4d8e000000b0034d191f6b83mr785469wru.13.1714429840760;
        Mon, 29 Apr 2024 15:30:40 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id i17-20020adfe491000000b0034cc9dcccbdsm5879530wrm.113.2024.04.29.15.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 15:30:40 -0700 (PDT)
Message-ID: <5e2dfd0e-d647-4106-9921-a78ca4b55403@linaro.org>
Date: Tue, 30 Apr 2024 00:30:39 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux PM mailing list <linux-pm@vger.kernel.org>,
 Yangtao Li <frank.li@vivo.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] cpuidle for ARM for v6.10
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Rafael,

please consider pulling this single patch PR.

The following changes since commit ed30a4a51bb196781c8058073ea720133a65596f:

   Linux 6.9-rc5 (2024-04-21 12:35:54 -0700)

are available in the Git repository at:

   https://git.linaro.org/people/daniel.lezcano/linux.git cpuidle/next

for you to fetch changes up to f9059eb5d73e65c88b88465abed4364dfc7b20b4:

   cpuidle: kirkwood: Convert to platform remove callback returning void 
(2024-04-23 09:21:48 +0200)

Thanks

----------------------------------------------------------------
Yangtao Li (1):
       cpuidle: kirkwood: Convert to platform remove callback returning void

  drivers/cpuidle/cpuidle-kirkwood.c | 5 ++---
  1 file changed, 2 insertions(+), 3 deletions(-)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

