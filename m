Return-Path: <linux-pm+bounces-24920-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 339CCA7F183
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 01:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0AF17F3A5
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 23:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF4E22A810;
	Mon,  7 Apr 2025 23:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="L2YOGPD3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7163121B8F8
	for <linux-pm@vger.kernel.org>; Mon,  7 Apr 2025 23:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744069775; cv=none; b=t+hH9C/9JPGeOTmOVMwjHFJkT/kLcCIxV0+vqiVcNT3S8KBE2JxBUFCCzIZvE0GIb0k3rqkM3TI4gJSJDH/0uFxybpHD1z3hxyHZGbcoE7P1696isTotiOEH8V12klcuKQzHZmz8jNy577BadGbIUTg5kG7xbja4lm4HWd/wwGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744069775; c=relaxed/simple;
	bh=SOz3vG7Jm/O1HWCz9lJv4YGTUeCHZOMa7Enen02WajU=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=SRHQiOfXqoIZ+hF+KYNIxYEBCBF4lVdY1r6q8C/PjMezgaFhsahTJHD/lsdeAmGZ9jQZifrmWCq1kRjgtPyIHoVZYmEcCD6V2WwMlHwPZ2MUQUdWqT/0hmEda1r7FZXA0uYoqKY/leW3/GfSts2zepPurILXrsquAy+ET1d1xnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=L2YOGPD3; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-af980595952so3169446a12.2
        for <linux-pm@vger.kernel.org>; Mon, 07 Apr 2025 16:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1744069772; x=1744674572; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2bpXYNg2Q2BZtYHIEGgpFB8yTDxvQVFgPQJVNFRPplE=;
        b=L2YOGPD3xoF/AXfVm/8F57ZnQxcmt0oLiZJ5V7dyk5yuGTj3OPnDwuthGHa0TLKg7s
         O7r11zJVapk4ksIlJ6WfltOf/hDd6eAGALsNspMr/37nrIOnJEAovbi3t1n3cQtfCTa0
         Dudj1x8uDj1SuVEPoLqvM+/7e+U57gqMb8Y8C/k4kUylao8FZRn7SyMB4eJlwD10irQp
         98Zy4JX2sTcw/wHMkqteQfo+07txxcmstwIoNgtPbFGmI2FPuNz8IL8+C1lsQZBukJtc
         ZnNhQsOdS54ZGvpdZLqUBUW6LgxegCs48w7pS+hW8CG1NUIRFlNFrsXHMwZQMRr4dhXS
         wr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744069772; x=1744674572;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2bpXYNg2Q2BZtYHIEGgpFB8yTDxvQVFgPQJVNFRPplE=;
        b=Tgq4u5n2A1WjC5/h+XLb7lAznFSUmY+AE6kcaCv6GT97h+dvWsbOrjAJ2EZHHm0KiY
         /mqd7obnNR5kZGvJV9E0eS90AU5Igvtdxjwe5XfpV2qTRiz/V3Ll1s0ZatHgplF3xs5O
         /r0F/QzCToo3Rjk+Tshgpyf80F2f6BjWTN9uREMp21BemDnux+umG6AX1IOxmCvouzrp
         QLOu5RePoT7+XHbzJuCWcly2QC0NBHWtFayVoYSDzZafeQKv4A0Rva6hpivfxnGqF4bS
         T780Kf23GB+0bWZr9JwnzGnEv4TtIFWGCNuv8ibhkL5swkIn2AJQy4qbE5Wm0yGnzBb3
         p4yg==
X-Gm-Message-State: AOJu0Yx8w4wYzDJcqUa8kMNhi4/aclebtKGJOYOHJ6ZaDDB8hItNliaU
	jmKZMpqo/cCJL1tAGRpA+WYyDkwBNY3T+kNX5P3l7H3KN7UGYJmVEZZD04iVEpI=
X-Gm-Gg: ASbGnctdRIxgttGtkfV2HmhP7UgUQUJjWiiZc/yklgHp0mtbC/ORiYdIHQBRIYqgmqn
	P8qohLj1P7AEVWarPsQw1AfuuI9k56+7iiuZ8fBnOWc4ySwWUu0lD6dZuhhAq2Z6y+Cqk5cCs5E
	iMSKskx/BfCFtm13/VNjuAph4wFd5GNjc69IJH39KA+Nr3PfC1nSXurexDzcJIpkBZjJhiv+VC2
	7jH9lTmQwwoiNrZgNWWw6XVAEWblkYltrOo9BsUC2LIm8mfES7dRab+Abg2kTMYgXbV0p5e3msJ
	xykxYqZSLcYfmc0sck7weqG8GmC00YLVV6kFb+PZKD0swASQeZvvDsCa0G/t9jgaS4rZKamUGWE
	GYh+z7RhG2A==
X-Google-Smtp-Source: AGHT+IFemBAq/3v8iYPDmDEujfCwWufabf3j8rLUdtZy/CVt2kmZmb2ogYEtZ9kEbdQwpJhlP4z6jA==
X-Received: by 2002:a17:90b:50c7:b0:2ff:71ad:e84e with SMTP id 98e67ed59e1d1-306a612c906mr20734260a91.10.1744069771670;
        Mon, 07 Apr 2025 16:49:31 -0700 (PDT)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3057cb8e2afsm9763402a91.42.2025.04.07.16.49.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Apr 2025 16:49:31 -0700 (PDT)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'srinivas pandruvada'" <srinivas.pandruvada@linux.intel.com>
Cc: "'Linux PM'" <linux-pm@vger.kernel.org>,
	"'LKML'" <linux-kernel@vger.kernel.org>,
	"'Viresh Kumar'" <viresh.kumar@linaro.org>,
	"'Mario Limonciello'" <mario.limonciello@amd.com>,
	"'Sudeep Holla'" <sudeep.holla@arm.com>,
	"Doug Smythies" <dsmythies@telus.net>,
	"'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
	"'Rafael J. Wysocki'" <rafael@kernel.org>
References: <4651448.LvFx2qVVIh@rjwysocki.net>	 <8560367.NyiUUSuA9g@rjwysocki.net>	 <CAJZ5v0iMYSTnX9mkZb8aEmtbKxWOgsshNJ_AqnB9Mn27y8jzeQ@mail.gmail.com> <2362a42de1403e99a66551575efd910cc92980bc.camel@linux.intel.com>
In-Reply-To: <2362a42de1403e99a66551575efd910cc92980bc.camel@linux.intel.com>
Subject: RE: [PATCH v1 10/10] cpufreq: Pass policy pointer to ->update_limits()
Date: Mon, 7 Apr 2025 16:49:34 -0700
Message-ID: <005501dba817$b710fe60$2532fb20$@telus.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHyyTywk7Ob2ryTGJPPDQHQdNaAdgIkhChBAemkHNAByw3tNbM7zVSA
Content-Language: en-ca

On 2025.04.07 15:38 srinivas pandruvada wrote:
> On Mon, 2025-04-07 at 20:48 +0200, Rafael J. Wysocki wrote:
>> On Fri, Mar 28, 2025 at 9:49=E2=80=AFPM Rafael J. Wysocki =
<rjw@rjwysocki.net> wrote:
>>>=20
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>=20
>>> Since cpufreq_update_limits() obtains a cpufreq policy pointer for
>>> the
>>> given CPU and reference counts the corresponding policy object, it
>>> may
>>> as well pass the policy pointer to the cpufreq driver's -
>>> >update_limits()
>>> callback which allows that callback to avoid invoking
>>> cpufreq_cpu_get()
>>> for the same CPU.
>>>=20
>>> Accordingly, redefine ->update_limits() to take a policy pointer
>>> instead
>>> of a CPU number and update both drivers implementing it,
>>> intel_pstate
>>> and amd-pstate, as needed.
>>>=20
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>=20
> Hi Rafael,
>
>> Hi Srinivas,
>>=20
>> If you have any concerns regarding this patch, please let me know
>> (note that it is based on the [05/10]).
>>=20
> Changes looks fine, but wants to test out some update limits from
> interrupt path.
> Checked your branches at linux-pm, not able to locate in any branch to
> apply.
> Please point me to a branch.

Hi Srinivas,

You can get the series from patchworks [1].
Then just edit it, deleting patch 1 of 10, because that one was included =
in kernel 6.15-rc1
The rest will apply cleanly to kernel 6.15-rc1.

I just did all this in the last hour, because I wanted to check if the =
patchset fixed a years old
issue with HWP enabled, intel_cpufreq, schedutil, minimum frequency set =
above hardware
minimum was properly reflected in scaling_cur_freq  when the frequency =
was stale. [2]
The issue is not fixed.

[1] =
https://patchwork.kernel.org/project/linux-pm/patch/2315023.iZASKD2KPV@rj=
wysocki.net/
[2] =
https://lore.kernel.org/linux-pm/CAAYoRsU2=3DqOUhBKSRskcoRXSgBudWgDNVvKtJ=
A+c22cPa8EZ1Q@mail.gmail.com/



