Return-Path: <linux-pm+bounces-28391-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F817AD3C7F
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 17:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F39D1887F26
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 15:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C77C1D7995;
	Tue, 10 Jun 2025 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QAD11tw6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD49201034
	for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2025 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568385; cv=none; b=a7nEdQXazc6e+6DqoHEImdjPrffs2oMm1MsfXqAeerbTIvNy4o+f7U31nIM5t0pCGFjQG7B/BtQb7GXivRE8wbD6xSXAVD/Ktb+qezcjUjaHxQRkDAiyjQ3OzuSAWNqYcNXRj51JywPTcwPASqt6t6McAHKUPkgFWluLna7Soag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568385; c=relaxed/simple;
	bh=kZQny1cAxPye/n1el8HzBid9nHSdh3LxEWrjSsKYbKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V4pxrFVue8AFbiBw0BNzN14nVWSzeiLiz+KgTd1R9iPiWFOQbufZlLRRS6Ha8S+g0cdODkUI0HVYfgke6iRwZRZu/feliUYO3Ik5FZdCjjyVDl7xCwTRCIuszbuOaJE0Tl6//BIh5q4PF0aF0chH0xFIKWjL0BdfkzXPnyn0yjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QAD11tw6; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6fad8b4c927so50140646d6.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2025 08:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1749568381; x=1750173181; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1G90VU3NTpUnISqZJ7xyM3mHZw3huNrnbe2PvVxoUbk=;
        b=QAD11tw6k6GjZGmvRg71QsMl9+CMc74DWZMi5+zWJulPVLj0aqsvddKxhZ+1keOsNQ
         AVFnyHk0hcrZxplr03te6MZEb1jq7WDBaGMCCO3jdWNpQL0YLRMXo1I+ojJNeStoJyaW
         aqfWHcc0tOwaDUO3a0kHyTIMcNYC6KQ83BfzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749568381; x=1750173181;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1G90VU3NTpUnISqZJ7xyM3mHZw3huNrnbe2PvVxoUbk=;
        b=tAea/BkIG7w3RTxT/W1NY90OWrH6ECEr5CzwP+sW+b1CZ9aGAsR+EqFTFkdWb+tnnb
         Y6rLHGY59fCemiITv2RQAsiwRhpw3HN9vB3NrXQR69SSCetgJvlffLg8NSbcsIGgzIDs
         ItgogXtoWSGcDtgLcLwjkRE/kzFPha8nSfqaZ1Ob/7rbJny+fGEy+7AVO9B/bkXJ0YTy
         V9qPWuzT4gIo045bDalheew4eKS8NPtUZdCLaM4GnWnTlyzFptCXkQsBHWcAx5W9KPDK
         OAhWawFip6nDw3JQIfYLdPxLc01SutkX5Ft7FjykuVosHp6eD9HiBJwbazXNsoAjx/sP
         VBwg==
X-Gm-Message-State: AOJu0YweJjplpuTojxzn94QeDfv2GigqmVEFw538wGkG8Co9/MkWL+sK
	PC3pM7u8cs6vXKKwz3f6t0n/3KRMX9NDrfMQKrqsA3m+GbXIHNdAisvBBT/LbhTPgSw=
X-Gm-Gg: ASbGncsLdVLMTKlmM5pcbVhNjNf1l78pWkkj1GMhCMyeVz8BctLoEKdtNHxJ0QL2Xw9
	2ZMaWQwsEj27jFi/exfJV5IeqHf4W2jRo2D1bmRktwoTCEYwunGsnutikcf+3MxEilcpX1Qxc9o
	kkIG/inI6Z3TOspDTIkY9SATeFzKCP5sQsjAGtu6KvVpxKw/UjCGBHABqZ8tfilggS77yXEs3kO
	DxSeiETchoz+Ybsmc1tGJACDrekN8h5s9myjj7+Qxw0cgyIEHcs3i0rltqJuSopqgHsD7N2fFY0
	tEKGrpWdb9XSomnNDgiGDZ9rX+XMO83ZfBd5/f5eMOOLujZelE8frn7u10jt4hloOtpr6NjtuHR
	O
X-Google-Smtp-Source: AGHT+IHuunM03hGGpFWfO2kEd1Fz1zj1+dxV4jFUc+vOXYjB5Z+0KnIknlW2+I7Z9yc4H48Q7Ks7RA==
X-Received: by 2002:a05:6214:b6d:b0:6fa:bb26:1459 with SMTP id 6a1803df08f44-6fb08f4f665mr283080356d6.7.1749568381501;
        Tue, 10 Jun 2025 08:13:01 -0700 (PDT)
Received: from [10.212.144.179] ([12.216.155.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb09ab948dsm67168676d6.11.2025.06.10.08.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 08:13:01 -0700 (PDT)
Message-ID: <e08b042c-0786-43d7-9b2a-21197cbb1458@linuxfoundation.org>
Date: Tue, 10 Jun 2025 09:13:00 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: split unitdir from libdir in Makefile
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: linux-pm list <linux-pm@vger.kernel.org>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>,
 Justin Forbes <jforbes@redhat.com>,
 Francesco Poli <invernomuto@paranoici.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250521211656.65646-1-invernomuto@paranoici.org>
 <6deefc69-856e-44d7-b970-2f0127090539@leemhuis.info>
 <20250523002113.ca1ff066061da6049721c275@paranoici.org>
 <af43cc33-2f10-4664-982c-444a5f9717cc@linuxfoundation.org>
 <b9533ccd-b38d-437e-8315-3ca4672d1b69@leemhuis.info>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <b9533ccd-b38d-437e-8315-3ca4672d1b69@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/7/25 01:50, Thorsten Leemhuis wrote:
> On 23.05.25 19:06, Shuah Khan wrote:
>> On 5/22/25 16:21, Francesco Poli wrote:
>>> On Thu, 22 May 2025 13:43:49 +0200 Thorsten Leemhuis wrote:
>>>
>>>> On 21.05.25 23:14, Francesco Poli (wintermute) wrote:
>>>>> Improve the installation procedure for the systemd service unit
>>>>> 'cpupower.service', to be more flexible. Some distros install libraries
>>>>> to /usr/lib64/, but systemd service units have to be installed to
>>>>> /usr/lib/systemd/system: as a consequence, the installation procedure
>>>>> should not assume that systemd service units can be installed to
>>>>> ${libdir}/systemd/system ...
>>>>> Define a dedicated variable ("unitdir") in the Makefile.
>>>> Many thx for doing this!
>>> You're welcome!   :-)
>>
>> Thank you both. Applied to m,y cpupower branch. Will include it
>> in my next pr to PM maintainer.
> 
> Thx. Sorry for pestering, but will you send that PR any time soon? The
> current state of things in mainline creates small problems downstream;
> not a big deal, but would be nice to get this resolved properly rather
> sooner than later my mainlining this change.
> 
> Ciao, Thorsten

I am planning to send it today. I ran into merge issues when I tried to
send it on Friday.

thanks,
-- Shuah

