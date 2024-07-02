Return-Path: <linux-pm+bounces-10378-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DCB9247B7
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 20:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63021C24521
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 18:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92CC1CD5C6;
	Tue,  2 Jul 2024 18:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KTfAgzop"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ED21CD5B9
	for <linux-pm@vger.kernel.org>; Tue,  2 Jul 2024 18:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719946633; cv=none; b=nKwKq+iHZftJNX+PLf8w2KeP4F58cX8gF+bwHFviInWcSaT6FsNZxDxJg5O8iyfOGgElwdHyFgHmlDIFDeZ8Xy/iGhJw0DjH7JADnt7BYyHRzAuTwM6UiQsvvp0bwnsZOS/fJVMxy1JBUE52lu7IhlZ+q1IZHxmmXw1cASEQntM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719946633; c=relaxed/simple;
	bh=395FfH3xyemItAqtIn4JAJLEifepSzNJDc6f4+Ca/t0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZVPv/SuneFON1u5wdV8yQkUbnIRzTzz6gNBDJzltuY/qFlVoOlGGPYeCA4rpTq+xxrLDAoQeFCVC29RUll/fScSyLqHFsNY2Z2vvECTMMwMuIsFz/qeLis28YMUACAsH3rUcfCRY6WmKqHZBhOri67/x8ICR2U2bdVklLOUTXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KTfAgzop; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-375deacb3e1so2419435ab.3
        for <linux-pm@vger.kernel.org>; Tue, 02 Jul 2024 11:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719946631; x=1720551431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aL4LL4Ha0vSgUoObHMQfmtayw/DD40MrTBIZ2B5uF0Q=;
        b=KTfAgzopUvBfwAjnN9oy9AjPdhynAFgjdt82VQu8SjKQUKX61z/O9sr4Vf6tYcu9BD
         ghHak/Da9SwB0hwfGOQ3qW2g7UgdupkTb1ANWdov0RaZD9jj5l2bcTMM4XtkFMAOfoDm
         F9bsDo9a01b2LZssSc+rXCccSzw9AOzon8Zr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719946631; x=1720551431;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aL4LL4Ha0vSgUoObHMQfmtayw/DD40MrTBIZ2B5uF0Q=;
        b=NZIB4tshBv2bkfdPDEXzUCsOlkBkKQNqqGpkABxhJQvrM6PKYwm0VEIGQiKaNyAB4c
         vRr4x4I0dkkMqQmJsTf6JCC6kcW7hIH+CNylTqbrOolinxBS6BhWNdENHeOcUt3oZmWq
         LFXADv5iT/z8INy0uxOmaMGuoY5yjCqEdyTkOS96dRyRaCrwAz8L/am0WbJ1dVupauAf
         wPcJPB/3FgnL4PhuxyMre9wC8FggmQga058d/p3syVSfRMJl9GH3hdfGi7NT5fJ84vqa
         xOhku1ey42pr5QHtqYdj9Dyae/lIR/dq932Vw03b2GY3Rn+IwmtNASHWlsotldsk6LXb
         mdBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLxW40jyWmwpZxhgbzO23rcrLq5F3wkHlisJHWO/U5Z0/XO9FiSZVWBN6eytSTkPBMb2NPPTk+yWk5oyQUvyc+l24bjfcFIcs=
X-Gm-Message-State: AOJu0YxB6RzSwY39erI6p+hNVUIeRLzWh9XRE2T+8kBShH0o7j9flV8z
	ni2JgkTFg0eembO4841Fm4PA4NKLrHXElhQOUQjrFvH2YNtvYGTqd3b9T3h1djo=
X-Google-Smtp-Source: AGHT+IHt3Y/VJxYBqGCtROlUks2wWRLkDb1nCKLi8QuYrby7x99CL5CbK8pGf/fuI+6Twv+MWKldsQ==
X-Received: by 2002:a92:3647:0:b0:375:a4f9:e701 with SMTP id e9e14a558f8ab-37cd4124f46mr82780445ab.3.1719946631117;
        Tue, 02 Jul 2024 11:57:11 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37ad4370c2csm24815785ab.58.2024.07.02.11.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 11:57:10 -0700 (PDT)
Message-ID: <a7e0810c-2d35-48c6-9140-1ebfa3edd660@linuxfoundation.org>
Date: Tue, 2 Jul 2024 12:57:10 -0600
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
 <f1261f1c-abbe-49e4-b0bb-b72af367da7f@linuxfoundation.org>
 <CALsPMBP42_oKJDegVQOzHUE00mie2Mh_aPyvyTUhgsnjQO1DDQ@mail.gmail.com>
 <501954d6-3f0a-4f1e-863b-c60353435700@linuxfoundation.org>
 <CALsPMBPkE=CCTgm8UcsdL7qEG+1u1H8NFYYTJvEMK3uXvg97Ng@mail.gmail.com>
 <CALsPMBP8HR8eETzuua1STdnLPwLb1-53ipQg1c3vcEN4inU65g@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CALsPMBP8HR8eETzuua1STdnLPwLb1-53ipQg1c3vcEN4inU65g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/2/24 12:52, Roman Storozhenko wrote:
> On Tue, Jul 2, 2024 at 9:40 AM Roman Storozhenko
> <romeusmeister@gmail.com> wrote:
>>
>> On Mon, Jul 1, 2024 at 9:40 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>
>>> On 6/29/24 04:48, Roman Storozhenko wrote:
>>>> On Fri, Jun 28, 2024 at 9:45 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>>>
>>>>> On 6/28/24 05:30, Roman Storozhenko wrote:
>>>>>> On Thu, Jun 27, 2024 at 7:33 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>>>>>
>>>>>>> On 6/27/24 01:49, Roman Storozhenko wrote:
>>>>>>>> When the 'cpupower' utility installed in the custom dir, it fails to
>>>>>>>> render appropriate help info for a particular subcommand:
>>>>>>>> $ LD_LIBRARY_PATH=lib64/ bin/cpupower help monitor
>>>>>>>> with error message like 'No manual entry for cpupower-monitor.1'
>>>>>>>> The issue is that under the hood it calls 'exec' function with
>>>>>>>> the following args: 'man cpupower-monitor.1'. In turn, 'man' search
>>>>>>>> path is defined in '/etc/manpath.config'. Of course it contains only
>>>>>>>> standard system man paths.
>>>>>>>> Make subcommands help available for a user by setting up 'MANPATH'
>>>>>>>> environment variable to the custom installation man pages dir. That
>>>>>>>> variable value will be prepended to the man pages standard search paths
>>>>>>>> as described in 'SEARCH PATH' section of MANPATH(5).
>>>>>>>
>>>>>>> What I am asking you is what happens when you set the MANPATH before
>>>>>>> running the command?
>>>>>>
>>>>>> It adds the custom search path to the beginning of the MANPATH variable.
>>>>>> I tested this case. All works as expected.
>>>>>>
>>>>>
>>>>> Let's try again. What happens if you run the command with MANPATH set and
>>>>> exported and then run the command. Can you send the output?
>>>>
>>>> hedin@laptop:~/prj/cpupower/install/usr$ echo $MANPATH
>>>> /tmp/
>>>> hedin@laptop:~/prj/cpupower/install/usr$ LD_LIBRARY_PATH=lib64/
>>>> bin/cpupower help monitor
>>>> ...................
>>>> man output
>>>> ...................
>>>> hedin@laptop:~/prj/cpupower/install/usr$ echo $MANPATH
>>>> /tmp/
>>>> hedin@laptop:~/prj/cpupower/install/usr$
>>>>
>>>
>>> Is this with your patch or mainline? Can you give cut and paste
>>> the man output here for the mainline coupower without your patch?
>>
>> The above output is from my patch.
>> This is the output from the mainline:
>> hedin@laptop:~/prj/cpupower/install/usr$ sudo LD_LIBRARY_PATH=lib64/
>> bin/cpupower help monitor
>> [sudo] password for hedin:
>> No manual entry for cpupower-monitor
>> hedin@laptop:~/prj/cpupower/install/usr$ echo $MANPATH
>> /tmp/
>> hedin@laptop:~/prj/cpupower/install/usr$
>>
> Based on our today's conversation the following is the output for the mainline:
> 
> hedin@laptop:~/prj/cpupower/install/usr$
> MANPATH="/home/hedin/prj/cpupower/install/usr/man:"
> LD_LIBRARY_PATH=lib64/ bin/cpupower help monitor
> hedin@laptop:~/prj/cpupower/install/usr$ echo $MANPATH
> 
> .............
> man output
> .............
> 
> hedin@laptop:~/prj/cpupower/install/usr$ export
> MANPATH="/home/hedin/prj/cpupower/install/usr/man:"
> hedin@laptop:~/prj/cpupower/install/usr$ echo $MANPATH
> /home/hedin/prj/cpupower/install/usr/man:
> hedin@laptop:~/prj/cpupower/install/usr$ LD_LIBRARY_PATH=lib64/
> bin/cpupower help monitor
> 
> .............
> man output
> .............
> 
> hedin@laptop:~/prj/cpupower/install/usr$ LD_LIBRARY_PATH=lib64/ sudo
> bin/cpupower help monitor
> [sudo] password for hedin:
> bin/cpupower: error while loading shared libraries: libcpupower.so.1:
> cannot open shared object file: No such file or directory
> 
> As you can see we can use MANPATH for correct help invocation, unless
> we call it with 'sudo'. I can guess that it simply
> inherits the environment variables from the root shell that contains
> no 'MANPATH' variable set with an ordinary user.
> 

sudo -s will inherit the environment. Check sudo man page.

> Worth mentioning this in an appropriate manpage?

I don't think so.

thanks,
-- Shuah


