Return-Path: <linux-pm+bounces-33024-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FCDB340AC
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 15:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF57A5E11FF
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 13:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DA9271448;
	Mon, 25 Aug 2025 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FyTy47B3"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8F62AF00
	for <linux-pm@vger.kernel.org>; Mon, 25 Aug 2025 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128542; cv=none; b=Da4ANS9yshGMmx64ggOzo5HzHkxxdcABLJ7wwjViBFhSkxbrt2e27HyOerqCVsPSWXYdqmM5WPbkXX0VQ3kHT8JT61zmooY/a9KR0aUSJ5zvliWzzC+60Hepfs26USerrle+JeOsCi38MDjCjJOI3CM/v8TZgHzDXRE1A+Zl0ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128542; c=relaxed/simple;
	bh=0yff2LpoJnHEQt5aTGtyODb0eaeMmkFCh6B9O8f7CpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMDVQkJ7dFdKINEtUbg+PHW31t9Nmu/kPAPXhwnP7c8hG9veLtBl0jWitFgMxzLW81UfPpCEyhSIOy/QKq8gE2fweCPmdKpTbsAV+COxXlFIUWciDAk3BJZUtQnuJy2KQJtG3rBZCmr7D2ZovKSRmeOrMpCsT8KSp6uOu2rZaJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FyTy47B3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756128540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xs+Tu3bRpdzcsjYBxYYo8Y02jOXY+XlScB6sBjefWzs=;
	b=FyTy47B36qb7YdJc/fbX3iELxXvpj/2Uv1qacpmbWl9Py0Qm8UisQUhN70DY2jIyPXVYyX
	tKN2nXRGOphewJbCP1A22ok+CJztn+i23YI2gicDcv18D+9zIk47JKyxvKsHPgpFnRO52s
	8EQ5sxFeGpT2JdHCVe6RMpeafUds9bI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-3IWPCdkCMoKCTvvvGJif2w-1; Mon, 25 Aug 2025 09:28:58 -0400
X-MC-Unique: 3IWPCdkCMoKCTvvvGJif2w-1
X-Mimecast-MFC-AGG-ID: 3IWPCdkCMoKCTvvvGJif2w_1756128538
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70d903d0cbaso79769236d6.0
        for <linux-pm@vger.kernel.org>; Mon, 25 Aug 2025 06:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756128538; x=1756733338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xs+Tu3bRpdzcsjYBxYYo8Y02jOXY+XlScB6sBjefWzs=;
        b=Vxq2faC5+JGLSKOKwwvRXz1FKJueQLyXzxCsnUqBrH3HgnCfjSH4OpbgvpRIZNotmf
         DxwY2eL1rz6vwWlFyvLFSVgToidVp0rzlOcba6tj10aq4kZSmIW9d1DOtLkHuqbIYTI4
         C17HAKI/yiQztOYIItA20KqtOUvheUum49qD0knftLtAhGMq3gYqlJuRqdfmKxiTNPRa
         QcZ3VukMzbGB8vQIYH+sTNSYO5D4/3c9gtc1wCn/kSa6KlTs4ci24p//fTqDuMu77zzs
         w1V20ALFT5sAstPtm3iAPCsp+ZZTqzWB2BlfGSKDFuRmFaudOH9tLhwbakmZvNB31Bvx
         LH3w==
X-Forwarded-Encrypted: i=1; AJvYcCUxS94H74YrP4SDRUogGpQuXTelVzx/EpMZwrYqazO8jmkT5Eq0N5h/0a/gNob0AWBTmZYqrBjSew==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIhrohaIwcnR8bL/VXpiIr7f+kVPK/yj10HyCj3N8ckUcXyt97
	eKbyeGmRA4NWwSRp2z4gBhAFj017yPEGVt88TKjDuaP+0sDl6ZA93ZdaQ0E8mu8kt126q8gY48I
	RX+9YqJQsC6ZVQCipuluMw2tMR1frr8QsdGIyqxjMQr3tGjO81YdE/uSdgmSs
X-Gm-Gg: ASbGncvHJvL73ILLULqpDCZlTQrncM1GYvBDuQwb2K6mjYO9Ez+8/xBwK2zwBiKXeV+
	mLA/ZfO0JZ3ypWqCdMZafZqBlj0o9D7MJQy461+OgsDA8wURqfMLF0D0coRkarSeZZaaDXmRmfn
	bGaBRCQik0ev5KPQux5vQnSsqJjBxmj+aYlJigzVwfnBNpjUOB1LI/h2aazedMvcnKvoueDS2dQ
	leKKSuJiatRbu3DUgt+vQDdZ4Te43QLPChxDvOYBOwNVhue7bcoYpb++pqbSUQj00QhnVBv23Fj
	qQfKFU51NDHpvwU40PDAy0GKPxEKrdhSyg==
X-Received: by 2002:a05:6214:518b:b0:70b:adf9:bce2 with SMTP id 6a1803df08f44-70d9837efe9mr94799966d6.20.1756128538238;
        Mon, 25 Aug 2025 06:28:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHu0YB1Y5ZYTZ2o7B0Gvk4C/QMLdG541HyJVolkrvoTFoJmhnpSpmIS4mvxM9BASZEQVvZlUg==
X-Received: by 2002:a05:6214:518b:b0:70b:adf9:bce2 with SMTP id 6a1803df08f44-70d9837efe9mr94799686d6.20.1756128537742;
        Mon, 25 Aug 2025 06:28:57 -0700 (PDT)
Received: from thinkpad2024 ([71.217.64.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da717df65sm45334096d6.30.2025.08.25.06.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 06:28:57 -0700 (PDT)
Date: Mon, 25 Aug 2025 09:28:55 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: lenmn dza <lenmndza@gmail.com>
Cc: "trenn@suse.com" <trenn@suse.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"sageofredondo@gmail.com" <sageofredondo@gmail.com>,
	"jkacur@redhat.com" <jkacur@redhat.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpupower: Add Intel boost state and frequency monitor
Message-ID: <aKxlFxZOlqfjaF_B@thinkpad2024>
References: <TYSPR06MB7600C90A1D3FA792F3284771BC3FA@TYSPR06MB7600.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYSPR06MB7600C90A1D3FA792F3284771BC3FA@TYSPR06MB7600.apcprd06.prod.outlook.com>

Please resend with the patches inline.

Please see: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#no-mime-no-links-no-compression-no-attachments-just-plain-text

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


