Return-Path: <linux-pm+bounces-58-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCA57F3E5E
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 07:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E8341C20A44
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 06:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4D015ADB;
	Wed, 22 Nov 2023 06:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kelvie.ca header.i=@kelvie.ca header.b="g59WxPJO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-108-mta194.mxroute.com (mail-108-mta194.mxroute.com [136.175.108.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976D4110
	for <linux-pm@vger.kernel.org>; Tue, 21 Nov 2023 22:52:50 -0800 (PST)
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta194.mxroute.com (ZoneMTA) with ESMTPSA id 18bf5cd7b19000190b.003
 for <linux-pm@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 22 Nov 2023 06:52:46 +0000
X-Zone-Loop: d55f1876180bc47c1ef2e2586ca2295b7b5a500a2210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kelvie.ca;
	s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:
	From:In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=QfrsEiNiDvgOHqYQ6HeW1TuewuwattdZa/64hKuNSYg=; b=g59WxPJOvbYMAlOnH2lNEavL0L
	rpgqZLJChp9ZYW1rFpk4PqPO9oawZKbvlWr2xwILPTUy0OTM1cmc6/IkKCQO697UI8PwZafyo3EQ7
	3x65ulcIxBc3lw2xGaPs3JE4V7QjAdhj0tM4ayaX/TbW2pupDYb7zkJA9yQw7wCGuE/zxf9QLep//
	3tyuJnfCDeJLGZc3WZT5P012jD3AN6rjrmzOvARSfx8+oJWJi3dDCdS2zXR2B3ofn8AX+oYJlyjN+
	UimljwkyfYHWRcLbjzyffWBOSSbYsSqWr8UAG+s5urfdIzoFebDLHbHD/wd5+xNyk/EAq8tbiSlyp
	uEa1biNA==;
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6b1d1099a84so6066129b3a.1;
        Tue, 21 Nov 2023 22:52:45 -0800 (PST)
X-Gm-Message-State: AOJu0YwDOptQtwhilgpDMqURbQrKviT2ESo3HiHwEU9GIece9wdR1NWT
	ke18NJ+t9jOf4euByBrRc4KZCvb5DSDOcnEOQqg=
X-Google-Smtp-Source: AGHT+IG+koEkX5ZF3q/yCEz5nlwSSt/P6D1AYVNMSttJf3wGncmvkqPTRcwXVi3Fx4veG0d9n3GznYuniitZ7alXzQg=
X-Received: by 2002:a05:6a20:2694:b0:18b:f77:7bbc with SMTP id
 h20-20020a056a20269400b0018b0f777bbcmr1006135pze.62.1700635964093; Tue, 21
 Nov 2023 22:52:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231114022503.6310-1-kelvie@kelvie.ca> <a66a805c-3e1f-4b9a-a38e-aca84b8678a6@infradead.org>
 <CAHC9VhR6mr0XRrq=Apy00HD3tdgpKi4RyMr8f5kdx2sjA0sfig@mail.gmail.com>
 <CAK2bC5rN_P7WP_E57wJjz+7icVjrwS0e6fqg_5uNaPhy3YR2dQ@mail.gmail.com> <CAHC9VhQeQcEKFKWi2pvGE-DhkaccqBn9Yf_+r7JbZ2UPN+z3-g@mail.gmail.com>
In-Reply-To: <CAHC9VhQeQcEKFKWi2pvGE-DhkaccqBn9Yf_+r7JbZ2UPN+z3-g@mail.gmail.com>
From: Kelvie Wong <kelvie@kelvie.ca>
Date: Tue, 21 Nov 2023 22:52:32 -0800
X-Gmail-Original-Message-ID: <CAK2bC5p94wfyzixC_bg5PMAJjM5J0vyBVt1ChN6vz53+_HRRwQ@mail.gmail.com>
Message-ID: <CAK2bC5p94wfyzixC_bg5PMAJjM5J0vyBVt1ChN6vz53+_HRRwQ@mail.gmail.com>
Subject: Re: [PATCH RFC] Add a lockdown_hibernate parameter
To: Paul Moore <paul@paul-moore.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-security-module <linux-security-module@vger.kernel.org>, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Id: kelvie@kelvie.ca

On Tue, 21 Nov 2023 at 20:53, Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Nov 20, 2023 at 10:07=E2=80=AFPM Kelvie Wong <kelvie@kelvie.ca> w=
rote:
> > On Mon, 20 Nov 2023 at 13:12, Paul Moore <paul@paul-moore.com> wrote:
> > > On Mon, Nov 13, 2023 at 11:01=E2=80=AFPM Randy Dunlap <rdunlap@infrad=
ead.org> wrote:
> > > >
> > > > [add security & dhowells]
> > > >
> > > > On 11/13/23 18:23, Kelvie Wong wrote:
> > > > > This allows the user to tell the kernel that they know better (na=
mely,
> > > > > they secured their swap properly), and that it can enable hiberna=
tion.
> > > > >
> > > > > I've been using this for about a year now, as it doesn't seem lik=
e
> > > > > proper secure hibernation was going to be implemented back then, =
and
> > > > > it's now been a year since I've been building my own kernels with=
 this
> > > > > patch, so getting this upstreamed would save some CO2 from me bui=
lding
> > > > > my own kernels every upgrade.
> > > > >
> > > > > Some other not-me users have also tested the patch:
> > > > >
> > > > > https://community.frame.work/t/guide-fedora-36-hibernation-with-e=
nabled-secure-boot-and-full-disk-encryption-fde-decrypting-over-tpm2/25474/=
17
> > > > >
> > > > > Signed-off-by: Kelvie Wong <kelvie@kelvie.ca>
> > >
> > > I would feel a lot better about this if there was a way to verify tha=
t
> > > the swap was protected as opposed to leaving that as a note in a doc
> > > that the majority of users will never see, read, or understand.
> >
> I've got to warn you that I have an allergic reaction to arguments
> that start with "the right solution is really hard, so let's pick the
> easier, worse solution." ;)
>
> I guess I'm still not sold on this idea, I'm sorry.

Not a problem, thanks for looking.

I do hope that hibernate on lockdown is one day properly supported though. =
I'd
imagine that lockdown will eventually be the default for most distros, and =
it'd
be a real shame to have to sacrifice hibernate for it (which is, in my opin=
ion,
indispensable for laptop use).


Cheers,
--=20
Kelvie

