Return-Path: <linux-pm+bounces-9703-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B58910E61
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 19:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69EEB1F22642
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 17:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427511B3F07;
	Thu, 20 Jun 2024 17:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z+GDbqGB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE901AF6A9
	for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2024 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718904181; cv=none; b=jtzdbJyGA32CZCnyBwndVMjwpAI4gM+q+nJCvMvkw7ZmFUUssxB7PbjVa5DzouvlTDpqVKUKo9Mmw5RUffxPh/z9YoVIge0C8ZMmyQ+udepUbhK+2FyOvgumdQBCRDze3eqjpH1VlGBlEa6H16QrETUKMVZUyhCCnwc/p+CbY24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718904181; c=relaxed/simple;
	bh=dGqdpgKnoFzxt/1JqRDSt2VOPFHQTnyo7UE9wp4/h3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/0Ek1/HVYySPHDpuQC/oA4KXcTFEKgJ5c491iDYj4XztOopHQJsgb/O35eudi7r2ntIbAQ8s44w0XuKWXabdBTsdk4C3xPpKrLSOfK6iT2D+R4fYB3SaS8sFcxCkMOpw9EkNYgA2uePMIZkAMHC0d9HSfHQ6eco5GVVo/rp274=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z+GDbqGB; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-375858224b8so438575ab.2
        for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2024 10:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718904179; x=1719508979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OUklhXc3nIP3mWF1NibOeapDL3PcfljHJQSn6gqwmNg=;
        b=Z+GDbqGBJTIK9zHphaROWTx13etvPKYZUSt0DCsNcVr5dUsPQovgVE7ZIlFb/d92zh
         KhIoT36t130dXHG8tGxjfMbDCXQHX27pykVuzAHtm5VefO8Y7dX77KKIyV6017WSd3YI
         yW+1nXswt6OhZ0Fs888r6omrbfSf646IUAuoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718904179; x=1719508979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OUklhXc3nIP3mWF1NibOeapDL3PcfljHJQSn6gqwmNg=;
        b=dniR6dT+v1MqNJhB3d+T0LWHkh1Q7OO+PUTZAFGYk5KFoJg7X6aAKYM/4M4F0HdmHT
         3TaZfVNWt7bPVgvkN48a3N08MgiKxHSm8GMAW+Ke6iTfracgo5g9G8CdY9XQ/EolT68o
         3/6V0o5SiGXpkHaaz3gLult8GJF/ScCF9wIduwu4+ATTcAPZd1KH+3cCtytoWS4kL+rB
         HYeoBniON37UNSgnePepJM3ho28hELUOEUFRa1uMgtHLOo2TZFMud3BHurQ19Xy5apNN
         4eumn8Q+U3tL+GgRFFjsSi0IQCziGz6VAapRb7mpd2VdImM4FQtRUzhBtJH4+6JR/o5K
         5jtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7wJRx0lCMeifJ08A1d4nbEkrqHykvxwAykQGjelJgX+xMnox2F70GS6H80k3W3R2hLPlqol4sj2rufmupLeIXpwsC1HztoFI=
X-Gm-Message-State: AOJu0YxRVSp+zcQTuL9y+Y2WWoaRz94W/9Y1EOe8TWw5Qe7xGQxm6xHU
	yugLisy+0BWdD6A7aZlWCbaqHt1LKdk/0ckyeqm3EBZBCXaUrbMSHF/rXZFOVLB3v3IKEEg6yHt
	W
X-Google-Smtp-Source: AGHT+IF1m1PzyR/MAUEpQ+FiMKdfadVksbQS0fB5/E17/ZnXAhfGTjgSFUzr33BvLS2B1hydmymFmA==
X-Received: by 2002:a92:d5d2:0:b0:375:a48d:fdad with SMTP id e9e14a558f8ab-3761d70ecc1mr54513105ab.3.1718904178676;
        Thu, 20 Jun 2024 10:22:58 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37620064c45sm9942825ab.4.2024.06.20.10.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 10:22:58 -0700 (PDT)
Message-ID: <fbb09ad6-9dca-46ea-9826-021adaca9cca@linuxfoundation.org>
Date: Thu, 20 Jun 2024 11:22:57 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpupower: Remove absent 'v' parameter from monitor man
 page
To: Roman Storozhenko <romeusmeister@gmail.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240619-change-mon-format-v2-1-6bcffbad2c06@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240619-change-mon-format-v2-1-6bcffbad2c06@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/19/24 00:47, Roman Storozhenko wrote:
> Remove not supported '-v' parameter from the cpupower's 'monitor'
> command description.
> There is a '-v' parameter described in cpupower's 'monitor' command man
> page. It isn't supported at the moment, and perhaps has never been
> supported. When I run the monitor with this parameter I get the
> following:
> 
> $ sudo LD_LIBRARY_PATH=lib64/ bin/cpupower monitor -v
> monitor: invalid option -- 'v'
> invalid or unknown argument
> $ sudo LD_LIBRARY_PATH=lib64/ bin/cpupower monitor -V
> monitor: invalid option -- 'V'
> invalid or unknown argument
> 
> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> ---
> Changes in v2:
> - Moved the detailed description from the cover letter to the commit
> - Link to v1: https://lore.kernel.org/r/20240618-change-mon-format-v1-1-efa263a8e286@gmail.com
> ---

Applied for Linux 6.11-rc1
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower

thanks,
-- Shuah

