Return-Path: <linux-pm+bounces-10570-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015F3926DEC
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 05:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DF33B21C22
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 03:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF6B182D8;
	Thu,  4 Jul 2024 03:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CkYGQFrH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70521755B
	for <linux-pm@vger.kernel.org>; Thu,  4 Jul 2024 03:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720062604; cv=none; b=Tc5GqYsOD81mFSd0gSCyCULk6mTAfulL6xbiGU1HVXNl6CxvFDGPfIZoG7ki/04Xmdto8igK5J3VdyGqp9FzVGV8Be4ce60WnHaIaqDQgoaSVGqrFioPWYS3k2gQ1mRSEcgBwKBXImu7A9o885u3udlEKFc5GC8KWCWCMxtiok0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720062604; c=relaxed/simple;
	bh=hki5iIMFNHbEsD/tTBvMKBYYVumg2clu5AcP3fU06G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxxhWdFIc5wlfx15360VaKJiCzhGvYIUpEXZWS6vWdL91t1S90aIpTx8QSqow7K3L+cTj+ytFWMDtcAiGz/gIkgvEn2k13djDPV4S8wU79bS4u8G45B+FFkJoKiTBgP7V5JtlWfls+xZqRZ+hArT71vEEvxtThRxF3f2wrqaQfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CkYGQFrH; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d55ec570a7so128582b6e.1
        for <linux-pm@vger.kernel.org>; Wed, 03 Jul 2024 20:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720062602; x=1720667402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=25KnsUopkysIBr2uTdSPXmQMFBU4Udb2z4yjgTYdwpg=;
        b=CkYGQFrHCowQP9HH4dZm4c6g7kGCkPkFLSJbNhqqydDFhgxCfurQTUDJ4BMOQzH9mF
         HZkgzF+jOR8SqX2kUtQ3r3OaKols+y3gk+6FTEoL132g1D/eLT/4bRaCGF0hz9Uq2M/v
         GNijpJUu+H1reiPhw5Ds5r33SO90Y+i88M67GwJEtLO8G6xsBMjlIh+j6RnnGmR83ijB
         Nipb8jaFUjaDCu1u6e2feauQPCNVa471rMgeuYFkc/kuocPFnOeKXfomSksqmivpcnAC
         29bT3S9bPZeZP3uS0Q9ILBOyEpeGVQ0e8/XtR5doeHiGQ/dUBNk5efsfD4FiI/7RAzes
         r5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720062602; x=1720667402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25KnsUopkysIBr2uTdSPXmQMFBU4Udb2z4yjgTYdwpg=;
        b=AngxcWcSFNaUmLIOWbAq8huUr8sBvqZB+E8tGDMxVURMVVqivgGm0GxNiBN4xmLV39
         2GkWyWAayM5DL95keMM/Iz7TeVA4aecWQFE4LwbFhN0LejnsBTZZpNcvit1o4Di3Bvrv
         EYQLw+KYACq7gqZMQU8tWt8Or8Fssi4w4QwvzbpVlBPYFV8TFPhGaUy7YjxqTiIy84K0
         /vk/CtqyomDHNPfJy99oeYVXuN1Nqc+669lb+U0NOnJj8wC/IVV+QQjuz1Vlq3eclzm/
         OI+c6lsVEY9cvz5wR2VTASwohBQ5N14ddV0S5nPBceyT8cZ5/UjAiPyAiCBS07M+JMSb
         +o1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRPte1kL107LV9UTH2Bk9vssl2gTwqsr2GWxTksQe30TwZD/S2fZ7awe05WPwgUdqzbB3f+rInBWi6HN15IFH+S7JGM/teBDo=
X-Gm-Message-State: AOJu0Yw1FfGwTt4jOYF0VjU365nxEP8QeDGHJGn05nkLP6aYzPHPml2/
	85FL1pJyoWNDcGjI22WWzjx8HnMi3DNOXBQ2joyaSQUFP338o6byv8ZkqJCqjtE=
X-Google-Smtp-Source: AGHT+IEihQyj4XFSMtMz5vsZU/RQnANpLyNp++2hhEn7OAX/jkTUQw8/zL/gyOLuMPNkWsj4ueRh5w==
X-Received: by 2002:a54:4888:0:b0:3d5:5bd4:75f6 with SMTP id 5614622812f47-3d914eb1089mr411097b6e.55.1720062601232;
        Wed, 03 Jul 2024 20:10:01 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6d41655fsm8773138a12.92.2024.07.03.20.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 20:10:00 -0700 (PDT)
Date: Thu, 4 Jul 2024 08:39:58 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] cpufreq: mediatek: Use dev_err_probe in every error path
 in probe
Message-ID: <20240704030958.h2m4t7qgk3sp33tn@vireshk-i7>
References: <20240628-mtk-cpufreq-dvfs-fail-init-err-v1-1-19c55db23011@collabora.com>
 <20240702055703.obendyy2ykbbutrz@vireshk-i7>
 <aa6e93bd-aba2-4e4d-bce9-04e818ac25ed@collabora.com>
 <20240702084307.wwvl5dchxa4frif3@vireshk-i7>
 <d6994f56-57dc-4a66-ad7d-1daa04788b22@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6994f56-57dc-4a66-ad7d-1daa04788b22@collabora.com>

On 03-07-24, 14:43, AngeloGioacchino Del Regno wrote:
> Yes it will, but `ret = dev_err_probe(dev, -ENOMEM, "...")` is still kind of a
> shortcut, as that will effectively assign -ENOMEM to ret, so that the error is
> still returned like before ;-)

Ahh, my bad. I missed that you are assigning `ret` again.

-- 
viresh

