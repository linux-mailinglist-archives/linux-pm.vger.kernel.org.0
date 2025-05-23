Return-Path: <linux-pm+bounces-27598-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C81AC2827
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 19:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E029A5435C9
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 17:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF8429713F;
	Fri, 23 May 2025 17:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PC/9lijA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D5C2036EC
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748020000; cv=none; b=KgCImkmozE9VnITsG79HEXgiQEijWRJ141cFOCwFBTaUThaMsluUqS3q+uZ3y8VsYdiTTEDdezqBDKy05rmMgl1y4lkA13PdylTGtImUJ0LGU+jORyEVZZ4M1sdAXqKSaexiCjS14wY4bhtQ1+OTB48ccyAE9U4uIYTNoGKxRZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748020000; c=relaxed/simple;
	bh=SlsLMFTU2a6VmLClpFT2NhRD/2n36ijFXKnNlVkmWyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GXl2wnrPX/XelXtbg4Wpe/IhxzLpkuEdmQZnKm1FRUG/IcSPPFfTZqSIyZJXmDqfbGulZcpMDIydOwBoe4RDyFuuY4LNp8oTuUZy3uIK6xfUQ3QWm2QL8GlecGvSPFk5AJPw2OIDrsgKQPHnwGcNbKLDNXA9QKcAFzcQHeI/nsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PC/9lijA; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3dc7830a386so506655ab.1
        for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 10:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748019997; x=1748624797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0gNG6XwBoxPhwT0fjplS9g3TyFfK5t28XXXuWyXQWEE=;
        b=PC/9lijAgqXImtHxkdXxOLtlgIkU0tPlY9oAT0xyReqdA9QDHiyWRL04pJSJ/WhOBw
         h5um5EjrqeXu9MfZPwXH+0vlT8+YKcATp0cilMrovtzXJIetC366uGpysesSSzQOM/lj
         dXO67KGUq0eGRGtlGooRFgtO4CYLTvt2tqtu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748019997; x=1748624797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0gNG6XwBoxPhwT0fjplS9g3TyFfK5t28XXXuWyXQWEE=;
        b=XDW5s2/MTDhwIVocYOt6REN+kAHNqr1qBgtIYbWPn3+Pg9SCtIqTIp8Ta0YSTbOUmZ
         aPYiRlCRUlLEIesc4iOl62rN2uaMIibbOd6keqxYnpVMTHwRdRtJQ3bwBeoFuYrjMcB7
         jLf1duE+dLRsvBvC7LooYc8NOr8vaBmdL7lMsJg/MpUrDWlEebMhDqwoHf3xJhwsrIOW
         NPtZmb3XzGKwuNoTS4P5aoUxCFLT3aeOYKONRuon8E3TZWWlpBsYrPJYIcv+IuGdH7Jq
         vt5bBXuBRSjbKu7Ni9ppk4tBkeMvSZmgrhvH1WOdTQM6TYv6q9lxn4TIQ1X8JqUemb6D
         Ycvw==
X-Gm-Message-State: AOJu0YzNGg6ki+0N7SrjfS3ft9btyx7mzyOB1DvPfEzJzbjv6mdqbgZO
	jO0eO1uBqUtaPsF2og06Snwq2/CQ12mqzbB9G5bdcCzSJxB1dKh/YQmREwohk+E7GkU=
X-Gm-Gg: ASbGncvQoZDd3ngWzo/vB+38UmtP1VqXSgUQFWgxNErQjFb3aPuHrMOGwwv2Rn9AfLw
	vvIyBPBe/k1QckZ/SxdCfV7d6R0AgEVLlsPMCqJrI6pMRoKbXwqTga8xjezRagckXsnyxyHVMzF
	DWUqjCmvWjOGzw2pNQUCX4+RWmY2Cog55/F6PVDh/1HDyb+24+LEb09pnL/oWraY57VxhBlLYvH
	O1W93+i6iGKJjCrM1HKbnT5PoJUxIla5m0iN1sEVjfE25vDAWy/ntGhIwYF8zz2oOGSNWI5y7uT
	4Ri5Fvk+VUisAXiGkpKTH5sx9rGgsPuFohhGCeLLMWz/JZ3zMuAtm3o7nVPciA==
X-Google-Smtp-Source: AGHT+IG/F05bn1Lxxqyb4oMFfM8AlXGm9yeMwef3T64CmF0x7EbkL9Tct6vhz5zsKPkAyvbYLPFvLQ==
X-Received: by 2002:a05:6e02:3d85:b0:3dc:8bd3:3cdc with SMTP id e9e14a558f8ab-3dc93243ea9mr38278545ab.3.1748019996776;
        Fri, 23 May 2025 10:06:36 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3db843e17e8sm40529005ab.30.2025.05.23.10.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 10:06:36 -0700 (PDT)
Message-ID: <af43cc33-2f10-4664-982c-444a5f9717cc@linuxfoundation.org>
Date: Fri, 23 May 2025 11:06:35 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: split unitdir from libdir in Makefile
To: Francesco Poli <invernomuto@paranoici.org>,
 Thorsten Leemhuis <linux@leemhuis.info>
Cc: linux-pm list <linux-pm@vger.kernel.org>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>,
 Justin Forbes <jforbes@redhat.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20250521211656.65646-1-invernomuto@paranoici.org>
 <6deefc69-856e-44d7-b970-2f0127090539@leemhuis.info>
 <20250523002113.ca1ff066061da6049721c275@paranoici.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250523002113.ca1ff066061da6049721c275@paranoici.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/25 16:21, Francesco Poli wrote:
> On Thu, 22 May 2025 13:43:49 +0200 Thorsten Leemhuis wrote:
> 
>> On 21.05.25 23:14, Francesco Poli (wintermute) wrote:
>>> Improve the installation procedure for the systemd service unit
>>> 'cpupower.service', to be more flexible. Some distros install libraries
>>> to /usr/lib64/, but systemd service units have to be installed to
>>> /usr/lib/systemd/system: as a consequence, the installation procedure
>>> should not assume that systemd service units can be installed to
>>> ${libdir}/systemd/system ...
>>> Define a dedicated variable ("unitdir") in the Makefile.
>>
>> Many thx for doing this!
> 
> You're welcome!   :-)
> 
>>
>> Tested-by: Thorsten Leemhuis <linux@leemhuis.info>
>>

Thank you both. Applied to m,y cpupower branch. Will include it
in my next pr to PM maintainer.

thanks,
-- Shuah

