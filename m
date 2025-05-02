Return-Path: <linux-pm+bounces-26584-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6A1AA777B
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 18:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 525EA468281
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 16:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7672725EF8D;
	Fri,  2 May 2025 16:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CM4cqtmY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F8D25DD09
	for <linux-pm@vger.kernel.org>; Fri,  2 May 2025 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746204077; cv=none; b=OW0f20EqFI6Gw8LF9Gg4/DVYMVaKzTd4VXGpZJzQRM9qWtHd6NLw4EPLAqpLuO4FmQWB4RrKh/xI4eft2wXaQ6Tusza0Erm/QCZ9L9eBWEkIdFbgR3QLFOyuNhYjfmzkj2p7+iDJja3S+FdbtlLuM3+tK/MYcCAct1ZRyKx13GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746204077; c=relaxed/simple;
	bh=oNAlu6MT+V2EqEGSYGO0b4JAT6cyUbog4zgPamr/IoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O2h5jlF7vlAZOVTU8Q+Ug6eo98rTaBOLUWLYfqNV69131Kznq9NBWJ8n0rJYrcoEg+F9gKrwEFmpyVmoeJTg8WcHDa46ikaZNW6XZ9FlaKrdXHyDJouLH73NFYgClARcyhjS0timuZoFHmeU/Up0XU7+W2WlpSrpLGUM6wzQfGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CM4cqtmY; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-85de3e8d0adso53468839f.1
        for <linux-pm@vger.kernel.org>; Fri, 02 May 2025 09:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1746204074; x=1746808874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3IG962JZAe1A3SI+Pz8JUWM9S73nx5XqhaBnmZrR8/I=;
        b=CM4cqtmYRN+dSbdtWcPMOlTvh9L71H8YoYBeR8SgAPw1qzYIe5KibL7KFkbnibf91D
         mIySOMhYTMZ7fAD9uWLDgENVc8CaSbCEDjwdLbNN3W9aGtqfjibQd1ysybh5yUYdyKqr
         gb+I79ghVztUaOPfbKAzIodNkPLjl9uj6Mo6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746204074; x=1746808874;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3IG962JZAe1A3SI+Pz8JUWM9S73nx5XqhaBnmZrR8/I=;
        b=VjgU3xJQOhn3AkTR0iCAuukHb7377uEtN5OmX8wLPZ/0I0xLAcEfF3CL5aa1fm0UQO
         SmqNMk8agB7e+WzXmBr1uWNxg5/XYUfNYs4F4VmOdK4CDZaYN97vmm1SXwLn8tj2lmZB
         b9G518bxsz0skzZjQ5VjOmh/q4asKN8YG3hweNrBhT/1h1J5vS/jtdg+utAZKyfDHqwK
         FvwRKtZsgMk7ai67oWP4IJy62JCkkFIyqf/nsyUTIBHRymflSBUvU4LrS2smFPnNKrPz
         FWmrGXCvLhjEo29buXbRcKdEJhDtR/bInPcDUlEr0+2sYpBnmaEzdRn8qz04N+QEozcI
         b3fw==
X-Gm-Message-State: AOJu0YznE6KLLKILXRdw87d+gyv2l/ZiiOQv0mGURRjVnOgM9sYJW8/Y
	EXPsvdZJaZOMVcFiIdpW9DiWmtnXWsh8gB8a9bcNFV+9c3gYuVMpjK1gDtCIu2o=
X-Gm-Gg: ASbGncuKknIIlL/pb+TvWVU5/0jfINqfJsVeEyncoRIlnmzTatp5RtYHvZlkeTkXSRu
	3rGKOOd7YC+T7I7n9aT2GhGZcVd8RiCxrYycTtKQQoAXnG25Ku4mhNDxO6fIkIgmur+3EOUOvlV
	29XIciFp/fZJ8kGWa0ZtVg1/Aar7F2fcTJFW9NcP6virpiQIA+FZpu7AijRgMIp9voQXSDDQ1VC
	gitxaUlTuqxTQNZA7oDU+5L7bGHpkvOZq/BKrkhgjPXyRnOBbGQRzsGwo9OMlDjoUkSDkczccWf
	oL4ooU70F5GRj/00HfGgkNJ29IWd1wFwaJzg5ohnzmQTNAr19lw=
X-Google-Smtp-Source: AGHT+IGDkRXta/MsrVxEceXUyip7r5vgmZVm4jfLEJ/K10Z8FzUfWE0zWp94NxchOxLNpI7Hm5V8+g==
X-Received: by 2002:a05:6602:3e90:b0:85b:435d:2fcd with SMTP id ca18e2360f4ac-8669fac56e8mr496093039f.8.1746204073760;
        Fri, 02 May 2025 09:41:13 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f88a945d03sm473172173.71.2025.05.02.09.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 09:41:13 -0700 (PDT)
Message-ID: <bdc10540-2e4a-4f97-9007-e4b70db04c64@linuxfoundation.org>
Date: Fri, 2 May 2025 10:41:12 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpupower: add a systemd service to run cpupower
To: Francesco Poli <invernomuto@paranoici.org>,
 "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: linux-pm list <linux-pm@vger.kernel.org>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 John Kacur <jkacur@redhat.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20250425151024.121630-1-invernomuto@paranoici.org>
 <aBE9ly7vP0eryfMO@thinkpad2024>
 <20250502175309.05e66d43fc2654afb01721fc@paranoici.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250502175309.05e66d43fc2654afb01721fc@paranoici.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/2/25 09:53, Francesco Poli wrote:
> On Tue, 29 Apr 2025 16:59:03 -0400 John B. Wyatt IV wrote:
> 
> [...]
>> Adding my tags.
>>
>> Reviewed-by: John B. Wyatt IV <jwyatt@redhat.com>
>> Reviewed-by: John B. Wyatt IV <sageofredondo@gmail.com>
>> Tested-by: John B. Wyatt IV <jwyatt@redhat.com>
>> Tested-by: John B. Wyatt IV <sageofredondo@gmail.com>
> 
> Thanks a lot for reviewing and testing my patch!
> 
> Do I need to resend the patch (without any change) with these tags
> added to the commit message?
> Or is it pointless?
> 
> 

No need to resend. I will apply this later on today.

thanks,
-- Shuah

