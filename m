Return-Path: <linux-pm+bounces-10216-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE3391C6CD
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 21:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988BF286167
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 19:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CF974C09;
	Fri, 28 Jun 2024 19:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QXNmpUmz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF41873514
	for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 19:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719603956; cv=none; b=MiUUmS+nFL68iIamyKvvLPrvF9ENaRoIYHTF6W8PJMgvTzSqzAOHwtfWcn6qnYtNMVpQF/7DoPwo5Uhtb4Ru1ez6GduCRy4Cr1FOq2Lus1of+AZZ4h/LgBPE3DZLIpo8tMk4EHqQgVz/C9aA7F2cfbN/B+MRKu7hK3yz8xqvdFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719603956; c=relaxed/simple;
	bh=H6sDvQFpHpw0Rc2a1DhQlzCPAHSVJqQJGxNnUBOfnwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GEeUYYSIzhsQG6NXWA4t/hbF27zlR88nTZ8GJ8YklKdtAtAbEAu1iSEZ5eQI5Gm5QH1SYpUms/zLJzxjmlFx5XGqVr1cNpuoKbWYUC80mNXEE61lU1+6FP6TjZJj5jqR+em8OL4JP9UViRggmUJbNIpccrMNkVtYIW56/BUU6m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QXNmpUmz; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3762c172d99so596605ab.0
        for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2024 12:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719603954; x=1720208754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wFy2b8oVABYcj3xshUopT/e34dAfFxSX3qpBpatyN90=;
        b=QXNmpUmz/+7nvRkY9A68PsYZqslHEj7zcFiZ2xswe7DcNVEFcmI7k1f1bKVRe8sIzP
         MArhrtsQOztYStHymKNDFBYxRu5PwAtSABJsB4I7sFZ2a2lbzFMdl2XaXajINtqFJoYD
         phLxRbVUiCbwyrkhgBUPlASizoPg++qz/kUpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719603954; x=1720208754;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wFy2b8oVABYcj3xshUopT/e34dAfFxSX3qpBpatyN90=;
        b=eloJB1BFSQin8auyVs13mvpqJvoWOYMbwe9xfF6VHCxkuOL7ehfjvRKviW4NJBFoa0
         lteWdmknEy1bW6qn+dS0RbuR28cHQdvLOzCO29T4Fcbd92s6E/PvJXovrq6G1dn3vIZJ
         CVjeEhyf8a5kmzZyek06FM22scrctMxOo/nuN43iWJm6gFjMZ9C4tQk/5j2HKfXn3eqb
         y9hB1YE4p1nZlB7htPDWYsGodGn53hVJSXnV8My4Gf359KNJVXsKxuw5Pt8YzWoL/rcn
         jqa1PEfaFvO5jJe69JZx31u9G+TySB9fKRHhdRPG6RdACRga/gbpcmIM4cPF5ae+qGLM
         aeRg==
X-Forwarded-Encrypted: i=1; AJvYcCXW0eVtPsSCckGVKDca/lr82UXr+YYHW4mlVzlhW3Fm/FRAoyN2VMYCIMQzWe7x5oFdrFvJbF4RBGlmqoEa18KIjbcqkLYwL4I=
X-Gm-Message-State: AOJu0YxoIYZs6C6B/SPkDbR7j6oC4gWz4PUlioTMqAV1jSj/9Qd77w8l
	UuyGJ1e9YpRNr5nz4t38quE4rrnw/dJh76Gy/d5G0xCdLagD6TAyCryUaM6D/LaaUXWeGIn0aLz
	z
X-Google-Smtp-Source: AGHT+IHPYjY418V10PP89PM7T1NNet/PvWH3Qy86QLmNXQ7IR7y3dgq4cdm/cyZF8VR66Lh172wBGA==
X-Received: by 2002:a5d:984e:0:b0:7f3:9dd3:15bf with SMTP id ca18e2360f4ac-7f39dd317famr1651334739f.0.1719603953855;
        Fri, 28 Jun 2024 12:45:53 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb742bd3c8sm687734173.147.2024.06.28.12.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 12:45:53 -0700 (PDT)
Message-ID: <f1261f1c-abbe-49e4-b0bb-b72af367da7f@linuxfoundation.org>
Date: Fri, 28 Jun 2024 13:45:52 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cpupower: Make help command available for custom
 install dir
To: Roman Storozhenko <romeusmeister@gmail.com>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240627-fix-help-issue-v3-1-85318a3974e4@gmail.com>
 <c9df6637-6055-4668-b80b-a1a6e6be445e@linuxfoundation.org>
 <CALsPMBMeo5E9ZND0bPK089VHBZnybsigkvoC2r8BLCTjYt9QFA@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CALsPMBMeo5E9ZND0bPK089VHBZnybsigkvoC2r8BLCTjYt9QFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/28/24 05:30, Roman Storozhenko wrote:
> On Thu, Jun 27, 2024 at 7:33 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 6/27/24 01:49, Roman Storozhenko wrote:
>>> When the 'cpupower' utility installed in the custom dir, it fails to
>>> render appropriate help info for a particular subcommand:
>>> $ LD_LIBRARY_PATH=lib64/ bin/cpupower help monitor
>>> with error message like 'No manual entry for cpupower-monitor.1'
>>> The issue is that under the hood it calls 'exec' function with
>>> the following args: 'man cpupower-monitor.1'. In turn, 'man' search
>>> path is defined in '/etc/manpath.config'. Of course it contains only
>>> standard system man paths.
>>> Make subcommands help available for a user by setting up 'MANPATH'
>>> environment variable to the custom installation man pages dir. That
>>> variable value will be prepended to the man pages standard search paths
>>> as described in 'SEARCH PATH' section of MANPATH(5).
>>
>> What I am asking you is what happens when you set the MANPATH before
>> running the command?
> 
> It adds the custom search path to the beginning of the MANPATH variable.
> I tested this case. All works as expected.
> 

Let's try again. What happens if you run the command with MANPATH set and
exported and then run the command. Can you send the output?

thanks,
-- Shuah




