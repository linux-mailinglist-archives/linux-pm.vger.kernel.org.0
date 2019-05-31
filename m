Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90FCC31693
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2019 23:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfEaVWa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 May 2019 17:22:30 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40637 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfEaVW3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 May 2019 17:22:29 -0400
Received: by mail-pl1-f195.google.com with SMTP id g69so4489966plb.7
        for <linux-pm@vger.kernel.org>; Fri, 31 May 2019 14:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iTNgN4/VlCA0W95p4CulhjftDWk81O+IK05qnHflrIM=;
        b=idTUrPhsF9TpGZuUC1bRliLtS9ZWiTNSaCygW1w6J9GYZ9sBUWoI1634c5cj666MdG
         /s8FpT52XrHQrww/RVeQSf/syKZ9IP0++PTL85nuPSv0tvIaXTr3Ee/fk5J9A+DoE56c
         mIMSH1DACQYI647Ge6mUabpeMvJt4mm+Py7wue4fTB34zLM6M8S7KyjAY3pMkLS8nCzz
         E+mbg7oy8VaHQjEtYHfX+mgD1Eu6WzB+bb2Z8Ny8sqCsNl9Aq2Uzuo1XGjwWZN5MVEQy
         f0uc3ulIjQBgsEVeGVPEgoEdhGI0q5gqqockeCbcHkCV/7F9BTHOoSJnZp8dwpgo6LSv
         Mfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iTNgN4/VlCA0W95p4CulhjftDWk81O+IK05qnHflrIM=;
        b=hpXgnXTNwmVttNMNoNoX062ITFv2R8enJsGvGlvWJVbnBLZataa4jd0cUNLFkv37um
         Qpd/SfR7f8wDzP3V/Bm7Bklvpnwas9odPmo3Ir3o3Yx9hCzmfJ9hPP0ndiVu/qDrMkv2
         FvmKWHCjEtcIXX6PyHMfymUhjSVLPZqIScF/0/bN99uJJC8lM0yLv3qSTG9YlcPOpfZp
         qFTmJ+h1Pn5ZnmyRdXC21YOB/zj80FQMbqkGyay4nJp96cvMcmJdEkUc/FnhSNZZ9px/
         3YqB4PrjYZVs2eKL7u+zE0oCSAs8AwxVd8Zn0oK/oM3V1qpdQw0rJKFE0ntSl5OfyBn6
         YvTA==
X-Gm-Message-State: APjAAAWC+TqROqFbtzDNo7oBFikQrE3ZhY2I9dFo3o012Plh1crWmsh8
        xXP7ACxanfb3FCY9lWQD1AOu7w==
X-Google-Smtp-Source: APXvYqzKwbomY5B2az/Egexd5BkhQ/q2aE/79cH91klrLTdORsUINUzQvwmcUpnTC4sJlT5plVk9FQ==
X-Received: by 2002:a17:902:7581:: with SMTP id j1mr12044213pll.23.1559337749091;
        Fri, 31 May 2019 14:22:29 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:ec0c:2d9e:92:467e? ([2601:646:c200:1ef2:ec0c:2d9e:92:467e])
        by smtp.gmail.com with ESMTPSA id d24sm5678812pjv.24.2019.05.31.14.22.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 14:22:28 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4] x86/power: Fix 'nosmt' vs. hibernation triple fault during resume
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <nycvar.YFH.7.76.1905312251350.1962@cbobk.fhfr.pm>
Date:   Fri, 31 May 2019 14:22:27 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <98E57C7E-24E2-4EB8-A14E-FCA80316F812@amacapital.net>
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm> <20190531051456.fzkvn62qlkf6wqra@treble> <nycvar.YFH.7.76.1905311045240.1962@cbobk.fhfr.pm> <5564116.e9OFvgDRbB@kreacher> <CALCETrUpseta+NrhVwzzVFTe-BkBHtDUJBO22ci3mAsVR+XOog@mail.gmail.com> <nycvar.YFH.7.76.1905311628330.1962@cbobk.fhfr.pm> <B7AC83ED-3F11-42B9-8506-C842A5937B50@amacapital.net> <nycvar.YFH.7.76.1905311651450.1962@cbobk.fhfr.pm> <CALCETrUQzZTRnvmOS09UvRM9UCGEDvSdbJtkeeEa2foMf+hF2w@mail.gmail.com> <nycvar.YFH.7.76.1905312251350.1962@cbobk.fhfr.pm>
To:     Jiri Kosina <jikos@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


> On May 31, 2019, at 2:05 PM, Jiri Kosina <jikos@kernel.org> wrote:
>=20
>> On Fri, 31 May 2019, Andy Lutomirski wrote:
>>=20
>> The Intel SDM Vol 3 34.10 says:
>>=20
>> If the HLT instruction is restarted, the processor will generate a
>> memory access to fetch the HLT instruction (if it is
>> not in the internal cache), and execute a HLT bus transaction. This
>> behavior results in multiple HLT bus transactions
>> for the same HLT instruction.
>=20
> Which basically means that both hibernation and kexec have been broken in=20=

> this respect for gazillions of years, and seems like noone noticed. Makes=20=

> one wonder what the reason for that might be.
>=20
> Either SDM is not precise and the refetch actually never happens for real=20=

> (or is always in these cases satisfied from I$ perhaps?), or ... ?
>=20
> So my patch basically puts things back where they have been for ages=20
> (while mwait is obviously much worse, as that gets woken up by the write=20=

> to the monitored address, which inevitably does happen during resume), but=
=20
> seems like SDM is suggesting that we've been in a grey zone wrt RSM at=20
> least for all those ages.
>=20
> So perhaps we really should ditch resume_play_dead() altogether=20
> eventually, and replace it with sending INIT IPI around instead (and then=20=

> waking the CPUs properly via INIT INIT START). I'd still like to do that=20=

> for 5.3 though, as that'd be slightly bigger surgery, and conservatively=20=

> put things basically back to state they have been up to now for 5.2.
>=20


Seems reasonable to me.  I would guess that it mostly works because SMI isn=E2=
=80=99t all that common and the window where it matters is short.  Or maybe t=
he SDM is misleading.=
