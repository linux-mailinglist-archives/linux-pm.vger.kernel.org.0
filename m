Return-Path: <linux-pm+bounces-14527-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 820FC97DD79
	for <lists+linux-pm@lfdr.de>; Sat, 21 Sep 2024 16:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4359A282322
	for <lists+linux-pm@lfdr.de>; Sat, 21 Sep 2024 14:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFA416F271;
	Sat, 21 Sep 2024 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vz4JIq3J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02782137E;
	Sat, 21 Sep 2024 14:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726930030; cv=none; b=hYMqfWvbYfPgzpZ+J/D9VbOMxefT8ljC8DNk2UOKgiyA21XlQSHTtOJ2rCARapBxG1rKizKQLsZ5q0Yjx0jmzQuuVWfUEMxLm/xMLqBMZD0Nsf/xmOJM7Hq9R+bPijtdpWJ3P0MILaUBdgRFzV4XuQjsNjWAQtZCPOgd0U+9wF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726930030; c=relaxed/simple;
	bh=ghgfc92VC4S8bZ0LoYbrwLMOwUBXqeJE0XIB0QNeB5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nBKbXiuD4OuMEjpdlGPCgw6F7uebc9Cey1WtCz1zi0A8JQr9wEKLSs6Gd2EEUJ1AdVPP23BIVoXE1nYB7DHGD4r1+1EDafWv42WRlXFmC+VrSFa9xDpqKRWCJhPjz0NtgEdU9mbhL+RziJfmGpdtynuDt1gpDB3OEWdCXXAqFFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vz4JIq3J; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8d6d0fe021so429520366b.1;
        Sat, 21 Sep 2024 07:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726930027; x=1727534827; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QJ0G8JcZKZHr/2uYQrLHFduik99pn7gwtkFFiLSU5eo=;
        b=Vz4JIq3JHMOOyZU5/Y41gCqRzaVCj5G1wmiYhhdBXwTWPhL/W/2ByxNiIKSeqNc6Jv
         Ln/wGl0xbcpoQPVwySmE/brPx0fYOCWE1Ljmi+lwkZRGG3XBSMXkc9iVFb7gLfa37DJC
         6EjagjGoP2dRsED4zDFvtTgBMDR3XwlLMoLqVvTTTU/7WHoWRZ7+yhriyYq+j8Tu9K+1
         X4iTi43/XHf+Y3GkrNjtE94lZpE/Bg+doa1OJlDVSl5Ar7M6TgaXi52LQmm7+2ovRxBt
         BdudLuLmJYxWoN0T5Ah2RPSkFIRqRETEg61gmvAXOc7zcSF7K7REBVDzJ1Rmq5zx64k3
         urqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726930027; x=1727534827;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QJ0G8JcZKZHr/2uYQrLHFduik99pn7gwtkFFiLSU5eo=;
        b=RuAuVxgavkMRwk+Q/3YdXs1ecV1rBJpg0DQns8xgiX7VJ6GAnnxhZu82e+VVSi0aPA
         WpPD7ik3+F00H9v3B8d82+aaaiG/uM03JTmeslARuWSogyZbr1ke1F9Vsivgtz6qYk07
         LDPW88TEQdFXQ6UBdbjqsi0k6cZ+beRHvzcBm6kJCjkCSbXjZMS5pDWyOHwLlLWiDQ1J
         WIspX1BSXFD9cROOlpdJDCvpXaywg/EJbD2+iMowlK7cBnReQ/09vmsW36Zvh/r0Vm4A
         W8txlwwW0s7zTcCtpV9EtxySMR6iKqCFzS0HxJu7c7oh/ZbhoMZKfsgpf8o7o6pV/87G
         dJsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxQkH9/ssgTfd23ZJsoF6+kvpZrBHaquO7C+bQCEkn+fFukXda5b7QWhSnp7zKNw7N4pa/Rq5TWA==@vger.kernel.org, AJvYcCXu9IjyqvCBuiYbnM3bM6E0rPpDHB1xhUYFIZRgUHaVauq1L2fXeGRHlGc8/OOhCMWvXKvTm1VFpHmsTaFpKJY0kxfwuA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFce0B4suxHJVO0byapWLfTqoSQbsFZXt8HSq5gvnuZMNeCUcP
	VfWq7u7C1S3oKQ2u1CSTlLATje1G2smLwaR5oTtkqIsR2RZwcoUE
X-Google-Smtp-Source: AGHT+IFciqWYn+X3dGZWaT8GRefBydUL8Sbz3sajEUwPk8AfAzMTlnxBQf7e3n5oLlGQouLCd5l0sQ==
X-Received: by 2002:a17:907:9343:b0:a86:963f:ea8d with SMTP id a640c23a62f3a-a90d516abaamr627663666b.64.1726930026909;
        Sat, 21 Sep 2024 07:47:06 -0700 (PDT)
Received: from [192.168.1.127] ([151.49.207.190])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f4510sm979084966b.67.2024.09.21.07.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Sep 2024 07:47:06 -0700 (PDT)
Message-ID: <31eb2289-633d-47d8-8609-e9994d7f8353@gmail.com>
Date: Sat, 21 Sep 2024 16:47:01 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] acpi/x86: s2idle: call screen on and off as part
 of callbacks
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: Mario Limonciello <mario.limonciello@amd.com>, linux-pm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, luke@ljones.dev, me@kylegospodneti.ch
References: <20240919171952.403745-1-lkml@antheas.dev>
 <20240919171952.403745-4-lkml@antheas.dev>
 <7c604018-59a3-4b70-83d1-06f0ed858b73@amd.com>
 <CAGwozwGSVAExH_9zCCKreC88J0FRU4ZM3RkBk==HvRwCUuuqLw@mail.gmail.com>
 <25b14b4f-96b7-453c-b876-6a46c4f3789c@amd.com>
 <CAGwozwHmd8yHzjbutOd4T39h5CZRh2rOWYH4V4AnLN+RXrRRnQ@mail.gmail.com>
 <f164e172-0030-48d0-9c33-aaaa6d0cc6ff@gmail.com>
 <CAGwozwGNg8XZcY0AhfMfKXJo4P4Xmvn7e2Bt2gZ-emSAsn24qA@mail.gmail.com>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <CAGwozwGNg8XZcY0AhfMfKXJo4P4Xmvn7e2Bt2gZ-emSAsn24qA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/09/24 08:22, Antheas Kapenekakis wrote:
> Hi Denis,
> thank you for taking the time to test the patch.
> 

Hello Antheas,

> First I want to give some context. I have tested variants of this
> patch on 6.11rc5 and linux-pm/bleeding-edge on both an Ally X and a
> Legion go. I experienced 0 sleep failures on both of them throughout
> my whole series of testing, on all variants of the patch. I did not
> test 6.11 final. So I hope you did A/B test, as it is not clear from
> your email. We have had a lot of issues with new kernels and suspend,
> so please make sure to test 6.11 stock.
> 

My tests were conducted on top of the released 6.11.0, as suggested to me by Mario.

> The ACPI error in the s2idle report for the _DSM is normal, Asus left
> a lid sensor call that goes nowhere below the CSEE call that turns off
> the MCU.
> 

Yes, there is a leftover call on lid in the ACPI, however it has been there
since the very first release and it has never caused any issue.

> I am not that well versed in s2idle traces, but from what I am seeing
> is that your controller suspends beautifully, but some suspends fail
> due to a PCI error? Then you have "[Errno 16] Device or resource busy"
> but no accounting of which device that is. All this patch does is move
> CSSE to happen outside the suspend sequence, whereas before it was
> done *twice* within the suspend sequence,
> 

Two notes here:
- there is no evidence, nor words from ASUS, that indicates calling CSEE twice
could be a problem, on the contrary, there is strong evidence that doing it only
once causes issues such as what I am having and/or controller returning
"every other sleep".
- This has never been a problem before and my device has been entering and
exiting s2idle just fine for the previous months.

> @Mario what are your thoughts?
> 
> The controller is expected to disconnect and reconnect to the device,
> we are not trying to avoid that.
> 

The controller is indeed expected to disconnect upon entering s2idle and
the fact that I can wake up the device using A,B,X,Y buttons is concerning
in this regard: such behavior has never come up in past months.

> We plan to do a lot more thorough testing next week on Bazzite (on all
> devices), however our kernel maintainer is feeling under the weather
> so it will take a couple more days for that to start.
> 

Please, do so before submitting any patch that is meant to change the
s2idle path for every existing device.

> Also, a small comment on this new firmware. This patch has merit
> regardless of what Asus does with the ROG Ally, it is both a feature
> and bug fix contribution. I would like to see suspend in Linux become
> a lot more modern, as it is a feature we are often asked about. Users
> want to be able to download games suspended for example. The Switch
> can do it, the Playstation 5 can do it, but uh Linux cannot? It will
> not cause regressions regardless of what Asus does, as this is making
> Linux mimic Windows more.
> 

This patch might have merit if you properly identify and address regressions
you introduced.

Windows does not show any sign of spurious wakeup nor aborts while entering
modern standby, therefore there is still some difference that must be
identified and addressed accordingly if this is the path to be followed
going forward.

> Then, to move on to your other concern. Hopefully, you conducted these
> tests with a stock firmware. I think you did. Secondly, to me,
> requiring a firmware update + kernel quirk + software quirk (as
> extreme mode will be MCU version dependent) is something that I do not
> find to be a very satisfactory solution. In any case, we are happy to
> hold this patch out-of-tree for our users with older firmware and then
> tack on whatever else is required for the newer firmware.
> 

I conducted these tests with the lastest available firmware that is
available to every user: exactly the firmware this patchset
is meant to target.

- Main Firmware: GA80100.RC71LM.318 
- Second Firmware: GA80100.RC71LS.318

On that note I want to add that the path taken for entering s2idle by
RC71L and RC72L is different as in the case of RC71L two MCUs are involved,
while with what is available to you (RC72L) only one MCU is present and
therefore you cannot assume that what works for your device also works
on the other.

Keeping the firmware updated is something users do regularly on this
device, even if it means booting to windows.

Beside, as for necessary kernel/software quirks, the new firmware is
expected to require none, at least for asus-wmi, so I ask you to leave
csee calls where they are now as in the future those will be used only
on non-updated firmware.

I also did the main testing with the previous 339 BIOS update, but
just finished confirming all regressions are still happening with the
latest available 341 BIOS update too.

> I will post an updated version of the patch later today, although it
> is functionally identical.
> 

If it's functionally identical there is no point in it: it cannot be merged
with these kind of regressions happening.

> Antheas

Best regards,
Denis Benato

