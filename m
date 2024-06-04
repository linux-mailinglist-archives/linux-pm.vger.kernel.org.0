Return-Path: <linux-pm+bounces-8578-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DF48FB715
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 17:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4221F25C0F
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 15:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEE3144303;
	Tue,  4 Jun 2024 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gjzjk9mW"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC901442EA
	for <linux-pm@vger.kernel.org>; Tue,  4 Jun 2024 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717514898; cv=none; b=J9nclSlNEcqZwnrsLg+UOgMdE3tUS88TiJ700xGCxfrf52uI30LpQNrchPd8BIB3g6ulOaih+SdtsYbPg82E3xoePHZWr23UZq4/sec6GKCQaPaiKdyqA7qsDRqUKhl6Vp9SU5TsMOJZUwqMvYT4GBWHcaex0wQ5nUxnwyOa4xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717514898; c=relaxed/simple;
	bh=e2aM5bi24fW4jX+euawpljzpEa3P3eFPiNOlYc3CLIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j95uIUya3EBaNff0FX6qSHx0/WVhFSSnFCLwivIObu+nFu+gtm+ltYWR5t7W5EI9Zods/GLlBHA+ZVTqi7zlbddB4jDK4qSuulDpuffckrohLF+9DY52OkdPmPJj2kU57AB46wRdwbdaGH4qwMYu+vksBIuTaDdc5Aviks2SNIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gjzjk9mW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717514896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vevD6PqPhwnaWMxk5nmU8UGLvy64ajKyPNaDY17hdc8=;
	b=Gjzjk9mWWGjfd8mkIGFqgXAcy1IfFlVp1psi1kbrrEZMU9usV3CL+EUHKEiW07jg+zqOoW
	yPbdEDirSGmZcVjmnJMIzWBI/bJcjCrVuICu4mfiOUXzNBjs9fDtJxr4bVGN3Y5eCRXTOQ
	o6cctXpFrNRrm5HLqww0k5lC0lZTKN4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-SnTCChgMNWW7cElqHdzgCw-1; Tue, 04 Jun 2024 11:28:14 -0400
X-MC-Unique: SnTCChgMNWW7cElqHdzgCw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-795091f6f0bso125155485a.0
        for <linux-pm@vger.kernel.org>; Tue, 04 Jun 2024 08:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717514894; x=1718119694;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vevD6PqPhwnaWMxk5nmU8UGLvy64ajKyPNaDY17hdc8=;
        b=d5laYe6fftZFLKTLJ/qfSl2Q9I2cwWSdTRjxJsXeEztD39WTTTpULSD2y/ytfJTAk/
         4CnJhLub1ushh8nHlwZWrOzWnpjGSuhqFV8H1x0u/t9yBOq1oZphb8ro2VWcMNQ4/ZvN
         ZNx0gP52Arv1X08GGHYCi8tOQU0nMs0McpsKjAuuJZmodj1yqogaZ7UYnjyL3gT4FWTy
         51OriRKBzDu5z3J1JN+yiCnC8+DgrUgFaoV9bQNXEZMBA4M5lKSfCwK6iVoBdUMjnB/V
         wd0uzZ2M5qNScnSQ3vMJew0OsWOA/J2a/Hhm+uqiIJ6ZKaoVuYaqrqVtrv2qMU4mRChy
         SVOw==
X-Gm-Message-State: AOJu0YwrRk90WEtYCQYxskPZ991SzcneAUR1+UqDjObC3cv9ERdRF5Q2
	bxgXpovoUiwR5RyfNIxm2X/t6kMrmgIexEdrZ/Qtn5MGYX5b3bWeyu65xztzwnvWD8SLLBGevP8
	yaQiThuLQxKfd0jki8DtAmitv8onLC4ryPrIZG6YwWA00nxkcYEMlVeJWcolG6E73FtS4LrlFZO
	vvhKr4Yand1SbgXAyCAPHkXKZQC10fdZoTsu/dcZU=
X-Received: by 2002:ae9:f106:0:b0:794:99d3:d223 with SMTP id af79cd13be357-794f5ecdf6bmr1054585985a.65.1717514893951;
        Tue, 04 Jun 2024 08:28:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGETiN1xYb+s15NMu7MGoUx3B3zceRz5lcvgQvBjHBrFPnq4rdxvhEXfGZ8IF9We6ruUKMEA==
X-Received: by 2002:ae9:f106:0:b0:794:99d3:d223 with SMTP id af79cd13be357-794f5ecdf6bmr1054583885a.65.1717514893525;
        Tue, 04 Jun 2024 08:28:13 -0700 (PDT)
Received: from [10.26.1.94] ([66.187.232.136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79522e15a10sm584585a.12.2024.06.04.08.28.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 08:28:13 -0700 (PDT)
Message-ID: <2830be33-eea3-4bee-9f4d-8d96544e4d80@redhat.com>
Date: Tue, 4 Jun 2024 11:28:12 -0400
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/power turbostat: make the '-n' command line
 argument work in all cases
To: linux-pm@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
References: <20240520185749.1404283-1-darcari@redhat.com>
Content-Language: en-US
From: David Arcari <darcari@redhat.com>
In-Reply-To: <20240520185749.1404283-1-darcari@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi,

On 5/20/24 14:57, David Arcari wrote:
> In some cases specifying the '-n' command line argument will cause
> turbostat to fail.  For instance 'turbostat -n 1' works fine; however,
> 'turbostat -n 1 -d' will fail.  This is the result of the first call
> to getopt_long_only() where "MP" is specified as the optstring.  This can
> be easily fixed by changing the optstring from "MP" to "MPn:" to remove
> ambiguity between the arguments.
> 
> Signed-off-by: David Arcari <darcari@redhat.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-kernel@vger.kernel.org

Is there a problem with this commit?  I don't believe it has been merged 
or otherwise replied to.

Thanks,
-DA

> ---
>   tools/power/x86/turbostat/turbostat.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index 98256468e248..8071a3ef2a2e 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -7851,7 +7851,7 @@ void cmdline(int argc, char **argv)
>   	 * Parse some options early, because they may make other options invalid,
>   	 * like adding the MSR counter with --add and at the same time using --no-msr.
>   	 */
> -	while ((opt = getopt_long_only(argc, argv, "MP", long_options, &option_index)) != -1) {
> +	while ((opt = getopt_long_only(argc, argv, "MPn:", long_options, &option_index)) != -1) {
>   		switch (opt) {
>   		case 'M':
>   			no_msr = 1;


