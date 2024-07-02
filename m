Return-Path: <linux-pm+bounces-10375-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27987924794
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 20:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0BD5281A00
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 18:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FDB1C9EA8;
	Tue,  2 Jul 2024 18:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DWvC4Xn8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A723D978
	for <linux-pm@vger.kernel.org>; Tue,  2 Jul 2024 18:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719946337; cv=none; b=rUi4tZsTYZFpt6SE6FLRV1OePkrQ3bEDkahpJCHSDg+ktj7jcwN2TQerl2r1jjVBnciwj/dyQgNBE7NxvP7Y2M2T0sP5eJSNhhY10tqovc1Q28cw5/Zn2iUMu0sB/BovBexgx+qTmy+Z1MK763tIxdHvYFzWu3d6Z1LyWZHSQJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719946337; c=relaxed/simple;
	bh=nX2JSTfXjKclpzMdJtbii+13ISgpz54cyEBXCGVD7xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HfXF/y1X+MDLZoERTT3Q2LL4DloKSjqxB/XX8quRK1lK12I4r+Kh3PN2sLSd/FnGGyIDXm2HHv2rgzhMB45hTN4Cd8E2PBlUtr8SSUI9+cc9sVlRiHszgsmyuhhGkDkhNbg4J0TFDL6zE9fKliMJEVW50z8XJt60G/zA9DBq53Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DWvC4Xn8; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-380d8ba4548so615875ab.1
        for <linux-pm@vger.kernel.org>; Tue, 02 Jul 2024 11:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719946335; x=1720551135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ukloyL0s6AhGY8p/5GWHHQTAQ9GjFzWJ+KbQ9W/wRYY=;
        b=DWvC4Xn8X0Ar479gcJGugruIAV/lOE5Zy0iKDNOeR0WG/Fe3P2I81D1d8AfHlJdm4X
         90/IMUVgA6h9VDd3VcmFO0qBcexUsQ6TYCzCc/z8YgQxhYRTog7QtXYSY0H8KoCC3uWq
         0nyz9Lx5JB7dlYuDN5Nx9RWJrE3Wo15PPpscw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719946335; x=1720551135;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ukloyL0s6AhGY8p/5GWHHQTAQ9GjFzWJ+KbQ9W/wRYY=;
        b=CJ+n219IswV83uoRuqZy1bDn6RHRN778DLu2G2bMks2IWPdVPVz/SM2WDTByFSFflG
         BbEoSh7Ut5gQ+HVEe2UvrciTU+0/n+78oQUAhJV+Ru99DFKrNI1t8lpdFNVlUALdTecV
         9WNRP9yXj+W46mXmY8cdbHyLXbDkUbssmpeGgKpkalMTEyOyb4fEBkD3GDG2O7KrqcQO
         2mmXwlRiWf08YkTPbePQmJwWh1YegZUxayJxAhRIe/RZmUQw+RyHpF6mDkMj+BdojLNE
         qrBffd4f9PCfR00LXEGIbqT/A7ySl6x+BXJzVxuGAVuwAokFrL6XigF7wbZEqrcw19YK
         ikbg==
X-Forwarded-Encrypted: i=1; AJvYcCV+8eFWmckn+mGxB3Uummho/H009rgWiq5TJUb4CIyq0SV5xQNuii6M6MuspuWs2ula6TZTtZDpBm8PWuhcouiAjKWIJceiit0=
X-Gm-Message-State: AOJu0YzwsegttDHGoB+1EEV6ig/2xeaui5Le1ZRUd7DBnQYMS8CMEQB+
	SWGOmB6bgFoDRmODxSlJlyXrScHcdF9bdMjLFQS1/jaFKbxENlIXLD1X3JjnpxY=
X-Google-Smtp-Source: AGHT+IH7e2yVeCigwwbkgcCEeLBD7ntKcbqjUkD154Q3NDtwmtjORUbMgB9XQ28NC1ZPMwHlrb8tOg==
X-Received: by 2002:a05:6e02:6c1:b0:381:c5f0:20d5 with SMTP id e9e14a558f8ab-381c5f0232bmr5497485ab.0.1719946335479;
        Tue, 02 Jul 2024 11:52:15 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37ad2981b83sm24538225ab.31.2024.07.02.11.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 11:52:15 -0700 (PDT)
Message-ID: <5949e5e8-a128-4e28-ac1a-4b01c2d91fa6@linuxfoundation.org>
Date: Tue, 2 Jul 2024 12:52:14 -0600
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
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CALsPMBPkE=CCTgm8UcsdL7qEG+1u1H8NFYYTJvEMK3uXvg97Ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/2/24 01:40, Roman Storozhenko wrote:
> On Mon, Jul 1, 2024 at 9:40 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 6/29/24 04:48, Roman Storozhenko wrote:
>>> On Fri, Jun 28, 2024 at 9:45 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>>
>>>> On 6/28/24 05:30, Roman Storozhenko wrote:
>>>>> On Thu, Jun 27, 2024 at 7:33 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>>>>
>>>>>> On 6/27/24 01:49, Roman Storozhenko wrote:
>>>>>>> When the 'cpupower' utility installed in the custom dir, it fails to
>>>>>>> render appropriate help info for a particular subcommand:
>>>>>>> $ LD_LIBRARY_PATH=lib64/ bin/cpupower help monitor
>>>>>>> with error message like 'No manual entry for cpupower-monitor.1'
>>>>>>> The issue is that under the hood it calls 'exec' function with
>>>>>>> the following args: 'man cpupower-monitor.1'. In turn, 'man' search
>>>>>>> path is defined in '/etc/manpath.config'. Of course it contains only
>>>>>>> standard system man paths.
>>>>>>> Make subcommands help available for a user by setting up 'MANPATH'
>>>>>>> environment variable to the custom installation man pages dir. That
>>>>>>> variable value will be prepended to the man pages standard search paths
>>>>>>> as described in 'SEARCH PATH' section of MANPATH(5).
>>>>>>
>>>>>> What I am asking you is what happens when you set the MANPATH before
>>>>>> running the command?
>>>>>
>>>>> It adds the custom search path to the beginning of the MANPATH variable.
>>>>> I tested this case. All works as expected.
>>>>>
>>>>
>>>> Let's try again. What happens if you run the command with MANPATH set and
>>>> exported and then run the command. Can you send the output?
>>>
>>> hedin@laptop:~/prj/cpupower/install/usr$ echo $MANPATH
>>> /tmp/
>>> hedin@laptop:~/prj/cpupower/install/usr$ LD_LIBRARY_PATH=lib64/
>>> bin/cpupower help monitor
>>> ...................
>>> man output
>>> ...................
>>> hedin@laptop:~/prj/cpupower/install/usr$ echo $MANPATH
>>> /tmp/
>>> hedin@laptop:~/prj/cpupower/install/usr$
>>>
>>
>> Is this with your patch or mainline? Can you give cut and paste
>> the man output here for the mainline coupower without your patch?
> 
> The above output is from my patch.
> This is the output from the mainline:
> hedin@laptop:~/prj/cpupower/install/usr$ sudo LD_LIBRARY_PATH=lib64/
> bin/cpupower help monitor
> [sudo] password for hedin:
> No manual entry for cpupower-monitor
> hedin@laptop:~/prj/cpupower/install/usr$ echo $MANPATH
> /tmp/

Why is MANPATH set to /tmp?

> hedin@laptop:~/prj/cpupower/install/usr$
> 

Okay. If you run the command as follows and get the man page for
it, then I don't see a reason to add code to make it happen.

sudo MANPATH=$MANPATH:path_to_custom_install_man_dir LD_LIBRARY_PATH=lib64/ bin/cpupower help monitor

thanks,
-- Shuah



