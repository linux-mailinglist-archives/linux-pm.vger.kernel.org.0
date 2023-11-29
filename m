Return-Path: <linux-pm+bounces-512-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7D87FDBC8
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 16:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C6D81C20506
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 15:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FA638F80;
	Wed, 29 Nov 2023 15:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="OKdKmHAm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71F0D48
	for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 07:45:34 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6cc02e77a9cso4252789b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 07:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1701272734; x=1701877534; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NwHFWowqWyDEb2Wwo3i4LmdcNM+GbWwDzbQkVnnqols=;
        b=OKdKmHAmvjl9q/t2sP/tDCb3CXHVAfY0esPUD2GjyHFmbjlShsPkvfYDOHheCW8+Be
         bxbDhVau2rP3cEEr2xSb4NJnh1qY+1JlIxA4txKsbgP2G8/0vawfDuX4PpVzXEtGs8t7
         oYQA49UiEshldn7wyFivEaXg+NfTZU6RNbJdHBgAXlDSAVXvbgccvaa8CpfTtLhnSIq1
         blJOt/iB4hU39UjXjIWpFEVcJ/wq99ZbdSUFx5NueOSRp/wi9DTifHWh/NDJis6C+nnR
         qFPhbayRz0e6X3YU3kBTOvIMbL1diz+QhohTm8glLjONwGE58xayvUFbAtlBaT2qcNSm
         eNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701272734; x=1701877534;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NwHFWowqWyDEb2Wwo3i4LmdcNM+GbWwDzbQkVnnqols=;
        b=KPNhe/4vVwB92Q2xqI/g9rG/qby+BRcZGU3fcYnPqhhm1220DL/WRZnLVryRYxSjFS
         wY1cmUO5J4lqWsf+miCYKKoQrcZIUBCgBqKk4ZhmExUvNNAx5TL+WTtmIDdcGdHoUAqW
         6RGOqVVfHk9cRuS1Yif/nqTJCaNJ9vUMiEu5PNLlVZ887mkt5OEKpNgbzB/HslaatY3S
         JR6DZEe004/JZe9WaK8UASbO0Xa7XukJJOSsvxdf2F33GBQabxcmc+lNruqt78dIv6Zm
         zI1tzHhBPc56OTPTIQNzDYYxqAkOhDopNexRwY11Vu6NdWTluHVcSirn+tmeUW0Tao+5
         NCfw==
X-Gm-Message-State: AOJu0YwqHlBhcNTeVICi2w8H69xkBCCuCcNX9r48BzUubBEMzVDSgY/A
	iVZmYqeusFi9DgMTZrgHYn/o9Q==
X-Google-Smtp-Source: AGHT+IGclN/oppycOMAUcuhAMoVqfAFTVeiSpxJjAg11vAVb0DKwhzWdIt65fU8WkFdg/gegVjNOlg==
X-Received: by 2002:a05:6a21:328a:b0:187:a75d:29dd with SMTP id yt10-20020a056a21328a00b00187a75d29ddmr25066343pzb.40.1701272734232;
        Wed, 29 Nov 2023 07:45:34 -0800 (PST)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id y28-20020aa79e1c000000b006cddecbf432sm474637pfq.96.2023.11.29.07.45.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Nov 2023 07:45:33 -0800 (PST)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Rafael J. Wysocki'" <rafael@kernel.org>,
	"'Jiang Yihe'" <jiangyihe042@gmail.com>
Cc: "'Jacob Pan'" <jacob.jun.pan@linux.intel.com>,
	"'Len Brown'" <lenb@kernel.org>,
	<linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	"'Zhang, Rui'" <rui.zhang@intel.com>,
	"'Artem Bityutskiy'" <artem.bityutskiy@linux.intel.com>,
	"Doug Smythies" <dsmythies@telus.net>
References: <20231129143132.32155-1-jiangyihe042@gmail.com> <CAJZ5v0jfEsNVu=fg+Xa118F=hCGGB33U5SbiqWeCMaVMqNpUEA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jfEsNVu=fg+Xa118F=hCGGB33U5SbiqWeCMaVMqNpUEA@mail.gmail.com>
Subject: RE: [PATCH] intel_idle: add Cometlake support
Date: Wed, 29 Nov 2023 07:45:34 -0800
Message-ID: <001701da22db$180872c0$48195840$@telus.net>
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
Content-Language: en-ca
Thread-Index: AQGdZaOMTCAu85nrZizeQdO70JhFLwDSqyoEsQRR5tA=

Hi All,

This proposed patch has been submitted at least once before.
(I think more than once, but only found 1)
Reference:
https://lore.kernel.org/linux-pm/20200227013411.1.Ica3bb9fa898499d94e0b0a=
2bfa08ec46c89d84fa@changeid/

I have a Cometlake processor and am not in favor of this patch.
Reference at to why not:
https://bugzilla.kernel.org/show_bug.cgi?id=3D210741

... Doug

On 2023.11.29 07:19 Rafael wrote:
> +Rui and Artem
>On Wed, Nov 29, 2023 at 3:32=E2=80=AFPM Jiang Yihe =
<jiangyihe042@gmail.com> wrote:
>>
>> Since the Cometlake C-State is supported, support for Cometlake =
should
>> be added to intel_idle. Just use Kabylake C-State table for Cometlake
>> because they share the same table in intel_cstate.
>>
>> Signed-off-by: Jiang Yihe <jiangyihe042@gmail.com>
>> ---
>>  drivers/idle/intel_idle.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
>> index dcda0afec..f83f78037 100644
>> --- a/drivers/idle/intel_idle.c
>> +++ b/drivers/idle/intel_idle.c
>> @@ -1418,6 +1418,8 @@ static const struct x86_cpu_id intel_idle_ids[] =
__initconst =3D {
>>         X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,             =
&idle_cpu_skl),
>>         X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,          =
&idle_cpu_skl),
>>         X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,            =
&idle_cpu_skl),
>> +       X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,         =
&idle_cpu_skl),
>> +       X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,           =
&idle_cpu_skl),
>>         X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,           =
&idle_cpu_skx),
>>         X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,           =
&idle_cpu_icx),
>>         X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,           =
&idle_cpu_icx),
>> --



