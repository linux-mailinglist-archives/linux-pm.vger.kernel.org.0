Return-Path: <linux-pm+bounces-9494-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341D290DB65
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 20:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D32B1C21C38
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 18:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D16F15E5BC;
	Tue, 18 Jun 2024 18:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LHfwOzSD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6143B13AD2B
	for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2024 18:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718734547; cv=none; b=arqZJu666jCI+h2u5WZKvg7MiY+que3g8RcdNGBkKw89wrrHsTuXaO1A2j7OAZirgAmsJzwDkpMor4iCCmZKWFAYJYn2hGv4GS+BogMxxPUatMW7dJ/2Y7qDKJrvu/EY0INAj9S8WYUnhWiUX4mEsBQhl4a8UelMh20G7EvhsRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718734547; c=relaxed/simple;
	bh=aKdByi2t9ezVC8qELDLL/Q5xfOYq4ucH6rDz+XIvfxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pYZodCbNjItsjQ9OvJuuRNYoSPsE50KgPrO6sSuqCf/Aa1O3RCjFzsqJnaquly0qNBfumQslUWyEJoEnrcpMU5H7Oq6nM+d8v+Qg4n3/bXUv9+MWSDv32jg6ch763OqSXVYoAeD+XBcAu5GF6rb5jZZ6RTZLDUvRkup+KG8hiYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LHfwOzSD; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7eedf4ae265so12476639f.3
        for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2024 11:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718734543; x=1719339343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WhEE+5HXcPdgotUkEdwOAr3W4Q0GP62JkSz9AEVwlOk=;
        b=LHfwOzSD6ZdT0GTUEqDGJ3zPMMHKhvjElkMsdWE/DeDRX3dSNcs2y/IEkMz/sSddjG
         gZ/wq4Cj270hUTEa+4R2TfGZv2vvlA/MnwhSnOJUoQ/qOu5wZWYD+lFIYApIeolnY8wF
         lvg72RuBYWY1Gu+ZImo+ukq1ahYKrBMP2Kbi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718734543; x=1719339343;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WhEE+5HXcPdgotUkEdwOAr3W4Q0GP62JkSz9AEVwlOk=;
        b=uoXq/Kp1g2NUN0T08D04o0OET06ub4osWmeeZ3JnGg9Bqlg8H1gFnBYeFtBSj6SPer
         smdd06/RuS69jlWA7JsQJDwJGKZz6QiaxN2PUHIyvKNTDXaxyUJW+1J5+dPn5VgmxugI
         0vbzY+/5N+nX9ZaGsGEnDcAcUtYx/kc78TpQdHlmHmdegTPaTV/txBtndjXKw6V/A3AA
         oE8F9E9QYtwVpvaJTnDD1nwjG0h+aI9pmxrtgbfiZSGv7fG60iKZHhziDVO1AgrztjjJ
         P3yxfAfrVzpSA8v5fhJIH6DHwg8tzYVD/4x3FBeL4T0cbOMbuipRIlkA/nrff+S/1sAC
         /ACQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFgUzscw7UfaWAOu3hcHHl0U6Blr25l3L02rsBwJA2BUferDYG2xrMWF1M9Xc/68bpSdLRLgfh0jGAt68C3ye1vhTWn202d1o=
X-Gm-Message-State: AOJu0YzCBA6kxKPRnciT7DUzAUXwPlIRVDwlf74oDP2XpZrobeuMjfAV
	dFC50ZN7Wu/fIJ+QNQNaLadHDoJLfvkdtoVnvjOD+O6cx+BlyuoyWQBY6Hhl9PM=
X-Google-Smtp-Source: AGHT+IHySq3zJMr5HcEvH6/sYnd61H4Ab5EnLVkmivleiwdJkksYB3RrNZVebyzujGR7vUQSBFWrDA==
X-Received: by 2002:a05:6e02:b4b:b0:375:a202:253b with SMTP id e9e14a558f8ab-3761d6faacamr5583135ab.3.1718734543309;
        Tue, 18 Jun 2024 11:15:43 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-375d866e27fsm22312155ab.14.2024.06.18.11.15.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 11:15:42 -0700 (PDT)
Message-ID: <058b9003-6e2b-421d-b614-d6d7d4665506@linuxfoundation.org>
Date: Tue, 18 Jun 2024 12:15:42 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpupower: Improve cpupower build process description
To: Roman Storozhenko <romeusmeister@gmail.com>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240615125617.180521-1-romeusmeister@gmail.com>
 <2ac9b1a3-fd42-48fc-b1c8-4c1986536ef9@linuxfoundation.org>
 <CALsPMBNSJQXz4zG_s=f1E6UbY-m98ibtnHoUDBPLq+x9wMQ5cg@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CALsPMBNSJQXz4zG_s=f1E6UbY-m98ibtnHoUDBPLq+x9wMQ5cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/15/24 21:19, Roman Storozhenko wrote:
> On Sun, Jun 16, 2024 at 1:05 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 6/15/24 06:56, Roman Storozhenko wrote:
>>> Enhance cpupower build process description with the information on
>>> building and installing the utility to the user defined directories
>>> as well as with the information on the way of running the utility from
>>> the custom defined installation directory.
>>>
>>> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
>>> ---
>>> V1 -> V2:
>>>    - Improved commit description
>>>    - Make changed line lenghts 75 chars
>>>    - Refactored the description
>>>    - Link v1: https://lore.kernel.org/linux-pm/20240613-fix-cpupower-doc-v1-1-9dcdee263af1@gmail.com/
>>> ---
>>>    tools/power/cpupower/README | 160 +++++++++++++++++++++++++++++++++---
>>>    1 file changed, 150 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/tools/power/cpupower/README b/tools/power/cpupower/README
>>> index 1c68f47663b2..2678ed81d311 100644
>>> --- a/tools/power/cpupower/README
>>> +++ b/tools/power/cpupower/README
>>> @@ -22,16 +22,156 @@ interfaces [depending on configuration, see below].
>>>    compilation and installation
>>>    ----------------------------
>>>
>>> -make
>>> -su
>>> -make install
>>> -
>>> -should suffice on most systems. It builds libcpupower to put in
>>> -/usr/lib; cpupower, cpufreq-bench_plot.sh to put in /usr/bin; and
>>> -cpufreq-bench to put in /usr/sbin. If you want to set up the paths
>>> -differently and/or want to configure the package to your specific
>>> -needs, you need to open "Makefile" with an editor of your choice and
>>> -edit the block marked CONFIGURATION.
>>> +There are 2 output directories - one for the build output and another for
>>> +the installation of the build results, that is the utility, library,
>>> +man pages, etc...
>>> +
>>> +default directory
>>> +-----------------
>>> +
>>> +In the case of default directory, build and install process requires no
>>> +additional parameters:
>>> +
>>> +build
>>> +-----
>>> +
>>> +$ make
>>> +
>>> +The output directory for the 'make' command is the current directory and
>>> +its subdirs in the kernel tree:
>>> +tools/power/cpupower
>>> +
>>> +install
>>> +-------
>>> +
>>> +$ sudo make install
>>> +
>>> +'make install' command puts targets to default system dirs:
>>> +
>>> +-----------------------------------------------------------------------
>>> +| Installing file        |               System dir                   |
>>> +-----------------------------------------------------------------------
>>> +| libcpupower            | /usr/lib                                   |
>>> +-----------------------------------------------------------------------
>>> +| cpupower               | /usr/bin                                   |
>>> +-----------------------------------------------------------------------
>>> +| cpufreq-bench_plot.sh  | /usr/bin                                   |
>>> +-----------------------------------------------------------------------
>>> +| man pages              | /usr/man                                   |
>>> +-----------------------------------------------------------------------
>>> +
>>> +To put it in other words it makes build results available system-wide,
>>> +enabling any user to simply start using it without any additional steps
>>> +
>>> +custom directory
>>> +----------------
>>> +
>>> +There are 2 make's command-line variables 'O' and 'DESTDIR' that setup
>>> +appropriate dirs:
>>> +'O' - build directory
>>> +'DESTDIR' - installation directory. This variable could also be setup in
>>> +the 'CONFIGURATION' block of the "Makefile"
>>> +
>>> +build
>>> +-----
>>> +
>>> +$ make O=<your_custom_build_catalog>
>>> +
>>> +Example:
>>> +$ make O=/home/hedin/prj/cpupower/build
>>> +
>>> +install
>>> +-------
>>> +
>>> +$ make O=<your_custom_build_catalog> DESTDIR=<your_custom_install_catalog>
>>> +
>>> +Example:
>>> +$ make O=/home/hedin/prj/cpupower/build DESTDIR=/home/hedin/prj/cpupower \
>>> +> install
>>> +
>>> +Notice that both variables 'O' and 'DESTDIR' have been provided. The reason
>>> +is that the build results are saved in the custom output dir defined by 'O'
>>> +variable. So, this dir is the source for the installation step. If only
>>> +'DESTDIR' were provided then the 'install' target would assume that the
>>> +build directory is the current one, build everything there and install
>>> +from the current dir.
>>> +
>>> +The files will be installed to the following dirs:
>>> +
>>> +-----------------------------------------------------------------------
>>> +| Installing file        |               System dir                   |
>>> +-----------------------------------------------------------------------
>>> +| libcpupower            | ${DESTDIR}/usr/lib                         |
>>> +-----------------------------------------------------------------------
>>> +| cpupower               | ${DESTDIR}/usr/bin                         |
>>> +-----------------------------------------------------------------------
>>> +| cpufreq-bench_plot.sh  | ${DESTDIR}/usr/bin                         |
>>> +-----------------------------------------------------------------------
>>> +| man pages              | ${DESTDIR}/usr/man                         |
>>> +-----------------------------------------------------------------------
>>> +
>>> +If you look at the table for the default 'make' output dirs you will
>>> +notice that the only difference with the non-default case is the
>>> +${DESTDIR} prefix. So, the structure of the output dirs remains the same
>>> +regardles of the root output directory.
>>> +
>>> +
>>> +clean and uninstall
>>> +-------------------
>>> +
>>> +'clean' target is intended for cleanup the build catalog from build results
>>> +'uninstall' target is intended for removing installed files from the
>>> +installation directory
>>> +
>>> +default directory
>>> +-----------------
>>> +
>>> +This case is a straightforward one:
>>> +$ make clean
>>> +$ make uninstall
>>> +
>>> +custom directory
>>> +----------------
>>> +
>>> +Use 'O' command line variable to remove previously built files from the
>>> +build dir:
>>> +$ make O=<your_custom_build_catalog> clean
>>> +
>>> +Example:
>>> +$ make O=/home/hedin/prj/cpupower/build clean
>>> +
>>> +Use 'DESTDIR' command line variable to uninstall previously installed files
>>> +from the given dir:
>>> +$ make DESTDIR=<your_custom_install_catalog>
>>> +
>>> +Example:
>>> +make DESTDIR=/home/hedin/prj/cpupower uninstall
>>> +
>>> +
>>> +running the tool
>>> +----------------
>>> +
>>> +default directory
>>> +-----------------
>>> +
>>> +$ sudo cpupower
>>> +
>>> +custom directory
>>> +----------------
>>> +
>>> +When it comes to run the utility from the custom build catalog things
>>> +become a little bit complicated as 'just run' approach doesn't work.
>>> +Assuming that the current dir is '<your_custom_install_catalog>/usr',
>>> +issuing the following command:
>>> +
>>> +$ sudo ./bin/cpupower
>>> +will produce the following error output:
>>> +./bin/cpupower: error while loading shared libraries: libcpupower.so.1:
>>> +cannot open shared object file: No such file or directory
>>> +
>>> +The issue is that binary cannot find the 'libcpupower' library. So, we
>>> +shall point to the lib dir:
>>> +sudo LD_LIBRARY_PATH=lib64/ ./bin/cpupower
>>>
>>>
>>>    THANKS
>>
>> This "THANKS" doesn't belong in the patch.
> 
> The 'THANKS' does belong to the patch as well as the 'interfaces
> [depending on configuration, see below]' line at the top.
> Those 2 lines are parts of the original file and show the bottom and
> the top of  the changed text area.
> Just in case, I tried to re-add my changes using 'git add -i' on my
> dev machine and found that it is impossible to get rid of it.
> And it's explainable, git wants to know the area of the text to change.
> Besides, applying the downloaded patch using "git am' doesn't
> introduce the second 'THANKS' word at the bottom of the text.
> That is, the patch applies correctly.
> I decided to experiment further and removed the 'THANKS' line from the
> patch that had been sent and checked it with 'checkpatch':
> hedin@laptop:~/lkmp/patchwork/patches/powertools/cpupower/update_doc_install/tmp$
> ~/prj/linux/scripts/checkpatch.pl
> 0001-cpupower-Improve-cpupower-build-process-description.patch
>                                                         ERROR: patch
> seems to be corrupt (line wrapped?)
> #193: FILE: tools/power/cpupower/README:176:
> 
> Returned the 'THANKS':
> hedin@laptop:~/lkmp/patchwork/patches/powertools/cpupower/update_doc_install/tmp$
> ~/prj/linux/scripts/checkpatch.pl
> 0001-cpupower-Improve-cpupower-build-process-description.patch
> total: 0 errors, 0 warnings, 166 lines checked
> 0001-cpupower-Improve-cpupower-build-process-description.patch has no
> obvious style problems and is ready for submission.
> 
> So, as you can see 'THANKS' is a required part of the patch.
>>

Oh yeah. I missed that "THANKS" is in the README.

Applied for Linux 6.11-rc1
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower

thanks,
-- Shuah


