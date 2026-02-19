Return-Path: <linux-pm+bounces-42865-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJVZBSHmlmkuqwIAu9opvQ
	(envelope-from <linux-pm+bounces-42865-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 11:29:53 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6837015DC8C
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 11:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28F5F3024958
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 10:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D7C333434;
	Thu, 19 Feb 2026 10:29:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BDD328B4B
	for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 10:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771496980; cv=none; b=gyMTpjNRRjQnAQlvTmiRxbB6ZKRNbZwCDKfbSbgaHcNGFDSI4TEKEV3mDB2njLj8XBZ+TlhI1BRLmSjaSITp2DuyRdLMjfjocuP4Dy9hmnk3OseSWsq5AlkxMhZmuQftdKsvkwgcyeCPva7lVLvoGW7ZcoCAYVngBcF/37DgR9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771496980; c=relaxed/simple;
	bh=2wVcxigiWF7bmx5zDNOy2YgF6Z3jZwMF/ktrBkzISyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K23IHbtpCj7du9x55DtrcJrwVphD5Vd+hw6SA5tNjSM5JP6OCT94uYTbTEHc2Q7X1Jf6kkcmhhem4dAyniJZRI2n4qQtr4JlfWCcIiNX3lss8o1RYdqQ3dch3pT1vpFQMhasLfgS18YG/kknQY36LUs6HlPN4B5Lx2CDFNxlIM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5fe086fb0baso496648137.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 02:29:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771496978; x=1772101778;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/iP8fek36cTZj7uGuQwlk+a5PJBqWvYn07ZjqPzOHk=;
        b=g07ytkVva9cbc5feI3S7aowIHM/fjrT89WRLR2h81g/Wr0qtdicKCx7BKKsoO1TMrz
         zKPMYQ6867CxutDNPV06WJ9I++ozRYx7uCEpO5iY4Bq6lbUWKQR/ALgk8K3auCqTZQ47
         ap3AqKXSiRyCbmocD/In5L/jVN3psac0VS7Uvtv+9z+E893uIVi/zA3TZjaIY287jp4r
         m20e3qhOwwcYXt08yiIIRc4QajfZhZzpog5wxH1x2ZcmlHj8lxxVRM5qnSANizyBDr0A
         TGYc7r/8F3qC7llRv9yQN5JLDCSndMe42akIOgWXiJJqurSlfstm/5MCBaYv3eBmkbU9
         VbdA==
X-Forwarded-Encrypted: i=1; AJvYcCWFi0kS+BtJZmf8cHYbGndoou5LrbVE+qMKwUUYf/5NihFxckDy4opxdo4wZWoF6r6iIR0cC/b7gw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUxr77RUJh4gsw88XDAn9CfLbdLt0U7DxoCbFkE+/syKyKxGvo
	92UsQdvOj30vF1xRVU/4gv1e5ugkwicWOjooIrC5A6FkqvUYW1GQjXhShvI/bbDE
X-Gm-Gg: AZuq6aJsXKLDDBkkLv2tf8RsTO5KK+O717sJf6pp3vrHG2KVYkpJ+3wKd0AnWHuaGqj
	YdckkDLjGe3YO8JeBuisOV170JHLw4EZ8GQUez+94R5hbUsk2KmWEM03y0PshxHL4NuuraGoqBz
	mWrOb7UGJ9EG20SIHzV994Zq7FThMgOm6MLYnKm94VGjroDpF3KjtrMydRSHGfvQnX3918NtYnX
	S6TsPxNRDa82jv2/EWdjAbuu6LJY7jb0DhefTQyy4Dgu+n296CR07/6VWNdn5kSq+oRw9UaazFi
	iYqVTcim8XJaRO4h0hyxZf34r7is7KZ+FqfRJPoI6FClpkzKwNjdHPprSqAQQPCvOEIySKtleMn
	rdWLvpU2LVkfl+sh3iBEdR8LuOIxOdBoMUNySzKUYCMJFcBjSxDDnYiCx+z0v8YUYVOok+xjmg1
	A/bONXkG4Q1XjcgwEjmDoL+GuyXM8GqXkBDAl1P0FIDAYu7zJYa92mYhcxfZv6bk+R
X-Received: by 2002:a05:6102:5488:b0:5f5:48df:b85a with SMTP id ada2fe7eead31-5fe7fde5124mr2180315137.40.1771496977766;
        Thu, 19 Feb 2026 02:29:37 -0800 (PST)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94afcdc345asm13864588241.0.2026.02.19.02.29.36
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 02:29:37 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-56750cb34c8so671937e0c.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 02:29:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVEEkUYGerTcST+pvKILjie+zmamaEDj7QDxSLqEwP1iQmAaYF7ksjv4JbUSUWQ71hnfkKjTyRO5w==@vger.kernel.org
X-Received: by 2002:a05:6122:2494:b0:567:2b94:2e6c with SMTP id
 71dfb90a1353d-568bf59a621mr2370313e0c.11.1771496976112; Thu, 19 Feb 2026
 02:29:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122-pmdomain-hierarchy-onecell-v5-0-76855ec856bd@baylibre.com>
 <20260122-pmdomain-hierarchy-onecell-v5-1-76855ec856bd@baylibre.com>
 <20260127151735.GA1699112-robh@kernel.org> <7hjywtzaiy.fsf@baylibre.com>
In-Reply-To: <7hjywtzaiy.fsf@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 19 Feb 2026 11:29:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdURxN=kBQHJKnsTVEQPeuB41r5kZy4sgFNqg=U2ynuZMw@mail.gmail.com>
X-Gm-Features: AaiRm519SaRshXGNVfvg14cRnmfkYROkGvJOkhQFEH8pcasVxqZP2kH1_tN-rv8
Message-ID: <CAMuHMdURxN=kBQHJKnsTVEQPeuB41r5kZy4sgFNqg=U2ynuZMw@mail.gmail.com>
Subject: Re: [PATCH RFC v5 1/2] pmdomain: core: support domain hierarchy via power-domain-map
To: Kevin Hilman <khilman@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	Cristian Marussi <cristian.marussi@arm.com>, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, arm-scmi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42865-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-pm@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.967];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-m68k.org:email,mail.gmail.com:mid,0.0.0.11:email]
X-Rspamd-Queue-Id: 6837015DC8C
X-Rspamd-Action: no action

Hi Kevin,

Thanks for your series! I became aware of it only recently, and read
it and its history with great interest...

On Wed, 4 Feb 2026 at 00:13, Kevin Hilman <khilman@baylibre.com> wrote:
> Rob Herring <robh@kernel.org> writes:
> > On Thu, Jan 22, 2026 at 05:14:00PM -0800, Kevin Hilman (TI) wrote:
> >> Add of_genpd_[add|remove]_subdomain_map() helper functions to support
> >> hierarchical PM domains defined by using power-domains-map
> >
> > power-domain-map. No 's'.
> >
> >> property (c.f. nexus node maps in DT spec, section 2.5.1).
> >>
> >> This enables PM domain providers with #power-domain-cells > 0 to
> >> establish subdomain relationships via the power-domain-map property,
> >> which was not previously possible.
> >>
> >> These new helper functions:
> >> - uses an OF helper to iterate to over entries in power-domain-map
> >> - For each mapped entry: extracts child specifier, resolves parent phandle,
> >>   extracts parent specifier args, and establishes subdomain relationship
> >> - Calls genpd_[add|remove]_subdomain() with proper gpd_list_lock mutex protection
> >>
> >> Example from k3-am62l.dtsi:
> >>
> >>   scmi_pds: protocol@11 {
> >>       #power-domain-cells = <1>;
> >>       power-domain-map = <15 &MAIN_PD>,  /* TIMER0 */
> >>                          <19 &WKUP_PD>;  /* WKUP_TIMER0 */
> >>   };
> >>
> >>   MAIN_PD: power-controller-main {
> >>       #power-domain-cells = <0>;
> >>   };
> >>
> >>   WKUP_PD: power-controller-main {
> >>       #power-domain-cells = <0>;
> >>   };
> >>
> >> This allows SCMI power domain 15 to become a subdomain of MAIN_PD, and
> >> domain 19 to become a subdomain of WKUP_PD.
> >
> > One concern I have here is generally *-map is transparent meaning when
> > you lookup <&scmi_pds 15>, &MAIN_PD is returned as the provider. It's
> > also possible to have a map point to another map until you get to the
> > final provider. The only way we have to support both behaviors is the
> > consumer has to specify (i.e. with of_parse_phandle_with_args_map() vs.
> > of_parse_phandle_with_args()), but the consumer shouldn't really know
> > this detail.

This is also the first thing I was worried about, when I noticed you are
not doing transparent mapping, but add an explicit hierarchy instead,
based on the map.

> > Maybe a transparent map of power-domains would never make sense. IDK. If
> > so, then there's not really any issue since the pmdomain core handles
> > everyone the same way.

AFAIUI, SCMI is not limited to the SoC, but may be used for the whole
hardware platform, so it could control power to external devices, too.
Once we need to map a power domain through a connector, we need
support for transparent mapping through a nexus node.

> I don't really know enough about potential usage of maps to know if
> there's ever a usecase for transparent maps.  However, the problem I'm
> trying to solve is less about transparent maps, and more about
> describing hierarchy in a situation where "leaf" domains of the same
> type (e.g. SCMI) can have different parent domains.

Hierarchy is indeed something that cannot be described with the current
SCMI power domain management protocol.  This includes external hierarchy
(your use case), and internal hierarchy: AFAIK, Linux cannot be made
aware of the hierarchical relationship among the different power
domains controlled through SCMI either.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

