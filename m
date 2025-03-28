Return-Path: <linux-pm+bounces-24594-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C39C4A75274
	for <lists+linux-pm@lfdr.de>; Fri, 28 Mar 2025 23:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67A8B1693E2
	for <lists+linux-pm@lfdr.de>; Fri, 28 Mar 2025 22:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1B51EC012;
	Fri, 28 Mar 2025 22:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hoeOdF66"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A69D1922D4
	for <linux-pm@vger.kernel.org>; Fri, 28 Mar 2025 22:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743200554; cv=none; b=kXCtQz45y2rv2/Hvv3iW0Js/g7xnkrJyIaxpteR0inaqnFuavRa0TLwg3hq4JCJ0EKN+F5dkn/zJpyx/sxqroq8kjlnyW8IHffHuspDDN79K5vi3qi7B7y18/ZYGj41Vlp7woNQtIakpmDFe1eL0nO7cQQBN+Xwh5fKA6rtj3mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743200554; c=relaxed/simple;
	bh=2TtEzalTVAUFpRhmX36xhedu2jS33IP+EHtIi1aO9TI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OfKmOQgSso2WUOYqUN/D0G2HZCl+WtbYxxoSjElXD0ETnJBt9KK3bL1D3qDwmmt7Uz7p0tMI0Dv0sip819MVZAqRqR7j40lFT8HF8UeOOTWoUWLt5L0RLnU65GR1h431PfRT6RBRy7EJF/DnKJW3Egf+ios/Yymyx33VZSHX3cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hoeOdF66; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-72bccda48cbso1689148a34.1
        for <linux-pm@vger.kernel.org>; Fri, 28 Mar 2025 15:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1743200552; x=1743805352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I1ZGCDlv9ERgKA56k0GnTlguJDy4fwrfWGUPa1KD9UI=;
        b=hoeOdF66wfZ/lUtrDubHZuekjQtpVmgMXL8yFhjoPm8yf/81NMGE2+wE9E2x/c+Zb4
         IMzHIfyrxHFBDR7zuzjTUVJiM/Lg3cGAuTfPyZ8SJcvCskM1L1cN5HEfr9AA6ZayJ28b
         B9BMUDXaeR8TrfodD/Zn5+DEi58MJ1jvilhT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743200552; x=1743805352;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I1ZGCDlv9ERgKA56k0GnTlguJDy4fwrfWGUPa1KD9UI=;
        b=nOQtnQ/A8gbIFp8UD9N5b5Mp5qYuFdYGqUY6KcgHGISMcpAnuYfzat6tl1yOe321Op
         +9H5lgmt+cSB+4LpgT/8wYXu4Ujx+Y+RCII0SdLnyng0vHSwOPrW9SLZvNEdohNZnEMy
         +cGaGk62AGTLQ6aee6u7u6+3Y1xYU8BoNsrzGqqR6Ni3mzgXGifMx9NDfcoUwfdhaLNx
         EFcGgAQNcyKAQiQhnAtHvuy7X26uP6pZq3OdM776+1mjqVOEBTIeSgo8eJeKfviDyfme
         iHTNKwSIWbnurxTlQTHmn8f4ZYS44rf0/EUTt1pe8l6sUPaoBWhu1zhev2R1BfeAuDXn
         Ro3g==
X-Gm-Message-State: AOJu0YyARxX/I6Il66AxU39dloqx74zo7LOirH/sMpVZ12ebbAG24fbI
	8a0IrXE9DMnrtCEESXDfzEzwoQqSqGdtGTAgI2D9GcsidwFNOgDUDwrpHhmeU5s=
X-Gm-Gg: ASbGncvYBE/XtywUntf5RqKKC7v+o0LlHKaWIfvLX/rFedZZFat5ZKuF13/95p2zGjS
	YBQFMvHyyCTgz0Uivo/e2EZii5QATEFtB3DRymEmtqb/iisgXmrrAC7rg2+2KmrKE025QEudgK4
	dsQSDyO9dMC90X1aEp2WGSob19niHzGthotVuL2XkCbdPPC8AphdcFxbEgRS8aqZCvfr/72JpM+
	ot4SCj2oiv7psa5HCxxjeVp2B3dX7PCuoUOGPocsufOiOb1ez6MKsowqiTcOZkFZl7ZiprdCVbx
	HveEuGo8Bmf4wRNe1gz4EU9pg7K70V0rtxVyWX0n1LQ3q0jR+pn3T3s=
X-Google-Smtp-Source: AGHT+IE/K7LSsaO36JlUCuvpDSMUs/e0i85vaou+poxgslPNgTeTFF5AF5P/f/TNjwdhXpixMoFQ/g==
X-Received: by 2002:a05:6830:378d:b0:72b:9506:8db1 with SMTP id 46e09a7af769-72c637778ebmr834252a34.4.1743200551695;
        Fri, 28 Mar 2025 15:22:31 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72c580fa72fsm530997a34.41.2025.03.28.15.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 15:22:31 -0700 (PDT)
Message-ID: <d98040d9-e931-472e-b661-c3c7b13522cc@linuxfoundation.org>
Date: Fri, 28 Mar 2025 16:22:30 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cpupower: systemd unit to run cpupower at boot
To: "John B. Wyatt IV" <jwyatt@redhat.com>,
 Francesco Poli <invernomuto@paranoici.org>
Cc: linux-pm list <linux-pm@vger.kernel.org>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 John Kacur <jkacur@redhat.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20250322180357.1c17a180f1808533de77f186@paranoici.org>
 <Z-FQwMuVf_p7FoHn@thinkpad2024>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <Z-FQwMuVf_p7FoHn@thinkpad2024>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/24/25 06:32, John B. Wyatt IV wrote:
> On Sat, Mar 22, 2025 at 06:03:57PM +0100, Francesco Poli wrote:
>> The attached files are tested on Debian GNU/Linux trixie (current
> 
> Would you please submit this in the form of a patch that we can apply
> to the tree?
> 
> Please read (note the no attachments):
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
> 
> We do this to easily be able to comment in the mailing list and make it
> easy for others to review.

+1 send patches we can review.

> 
>> I took a look at how this is done in the [Arch Linux package] and I
>> enhanced/modernized the systemd unit (the three files in Arch Linux are
>> released under "GPL-2.0-or-later" terms).
> Is this an issue Shuah?
> 

git grep "GPL-2.0-or-later" shows several instances. This won't be
a problem.

thanks,
-- Shuah

