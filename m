Return-Path: <linux-pm+bounces-43519-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GN4bEVgWp2m+dgAAu9opvQ
	(envelope-from <linux-pm+bounces-43519-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 18:11:52 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC161F4730
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 18:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CF1A3022633
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 17:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2023C6A52;
	Tue,  3 Mar 2026 17:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xLsog1D8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A73370D71
	for <linux-pm@vger.kernel.org>; Tue,  3 Mar 2026 17:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772557787; cv=pass; b=B+ag55LQT7XJI2SxLkSpku9JpnVEeBi1H1ucctmTOr0jJzKbTeDcedNv6D28hUSgBDe3GzZS1W6mwoDpyreUybeX/fqeM3/sRudgJGR07bCrMHKYbFkZGthoMIr+s2HP5VD3rP6amZT7Gyr+iIu1S0GUWC1A+0HsAtdUEH79A8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772557787; c=relaxed/simple;
	bh=rdt8oIf1//UQgJmdBNW4JtjdwtTIkUas8nwXJnGiyUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aFFeYU6eIS5nFlbRmLm5letU/Xl2eDkj3snpmO0xKUTISvFPWknmC3aOFbj5FpI9qGLHQunbcl2TdCI0xVH0Xd09XKFC/CXK9S9tlrU0vknU2zQjFNrAMBxo9O5CR5G6lVIaaNisqLEo+T14top0ol7NsleRBxm0vEYj8z8EyJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xLsog1D8; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-389f9e70ae6so101372131fa.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2026 09:09:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772557784; cv=none;
        d=google.com; s=arc-20240605;
        b=lULQrfJ0G6h1T3oW0fA5fIg/Hoaxs3qbLK4D8NOtyQplddVacYkJirMF3M+/X6hs1p
         b+3Q3WrYrdm1dCujd8xfMuIHoCYUyEtNNTafyMLMQCNR0GSic1xZ2pB74lPwMelX9Ypa
         E9+pB0BUFhQ3Uwcx7ybfHEFfucwveuNWHa+dU/IuwwSii1u6fLWTXhQAiBb3m4Az5/C8
         eIaA0RWDncIW4n3OE+x2DZZeeT4fIlLmcT3jfEhESOMsgjZtPxDPpguSbMxIjznJ6+qO
         oDDNhaMamBsCFiOw5kPP2XfnKrymaANeIjAq1O1K8mF7Ba5KHd94Oi5cduMcUDmHGlQk
         2aAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rlBdi6EAVEtO25NMwMX/W9R62nC12Yqbu1jwDW8XMHE=;
        fh=6LJFvDi7AcSjBgQbfDFi2aVFxiQy3nMjUy1PZoDQz/s=;
        b=Sky+N4LJQn/0v6n9avvfbdysHMTlEttKTYE0Z6qcayTBCjJXEcDsDXakIQ/SEF9CIr
         /T7ZsEp6vGwV7zsE9p1hcQlw9xKE3pYocHD6yRqPJTPhc62ga0hUaz7jWq9n8ctCW3U4
         p0bDxv2Yt8dAyaB06qGKSApsCiO08RuPMgghBkQoASX0IyswjDrJhljgvUaC8fam7Emp
         oP7Blany2W0yUu1eSmU4EEs+0j9GiU/rlNtvU7HAv4MUBNHoMkNFnR0BVDFOcMtsNlu8
         jL6RdbA6ZBOJtTrszS/sV3kE3JdwQwY7JPgxvM/KXxAGfoVrDFC6bnTsjtV9vouygi4y
         EITw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772557784; x=1773162584; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rlBdi6EAVEtO25NMwMX/W9R62nC12Yqbu1jwDW8XMHE=;
        b=xLsog1D8gvRfw38s4cFQ/f52YLirvXHDnACGmN+Pg53TzS31AMctE59zY2bp4ibYeK
         4Hvs5z/Dkw65wTQnovwaxbJ/YKuHjcyT/C629qet5nbOk9AeV47eau05s0+f9xV9U/W7
         QpRIa32cgvJRgOySTFt+E3eWhk2wzztnjS23PMd+U1Jamq5Iln1VIY6P/1DJ8/DygUlM
         VykeQcTrJmmYs7J06C5TKWUzuwBcFvQQlzhm+KcjuHO903COzfyypvPzXNDLH2YJvq0p
         eOjh0XrdCs9DfmNzJ8nFhVooUhyOEgMIfPz8gGr3LiBYn9wAlhgUlt4uTpCrTYf5WTj6
         JIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772557784; x=1773162584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlBdi6EAVEtO25NMwMX/W9R62nC12Yqbu1jwDW8XMHE=;
        b=UOhG4eu/TuXQAan3YAUDkNxuVO8s5UJ8n9m+C4Wd55KzFzqz4R+efEc/gpOtaQQair
         YwL38bSIAaoE/dGFQC3ND66Sa3IcRc13Fq9h8BofIdowsFpmpSMiXlzOZgZ+4wBTNE8F
         /qH5HJhooac8TksxuFXBOZm1qf7XeIhBFEQBiW/7zsLHrBnGIFmRCtwedt03N0/Bpw53
         5PVlLEPH/Vv3sdZYS2ufJGqpjwBuHbB8m+7NRUbhQHzmF8kBVp24ZJ4UuWY33HETzQep
         5FgrCNlYtwd2X6Ac+aJ8/M4vNN/dsTxoJg7XaWJAhSp0qr8Rce2Bn5TyFfPvyjMOIsMR
         4kbw==
X-Forwarded-Encrypted: i=1; AJvYcCUdnFznLVd2V0nNIat2pBBEr155BaOlhW1nekePKcGpDpCfeZ6ZBsabXpuxjRpdDpUujDgCTQ/OhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeJySq4BXPNQLNFK2dZavMOXnbn3DmzgmXM1KJMP9c3+svsRAl
	WrJvYuL/5PLQNr0MxKyvDqdG1fVOUTnZKsXKO6kwdWpYtbWjC37luhlX/T92gMbKNeDIWjiTeWO
	BdL9VS8hvYx+f8qsTwxSM35LNa1wQurz5Q25pfXIUDA==
X-Gm-Gg: ATEYQzzOQjs3/9E6SIO2iWB9sqPH2deisPKw3NT2SU44hqw5UDGin9gRboCDo67ORLP
	QMobkTNbSHDHNfLS+slqLII4e2oX/QwwbCVgVHEPCdPXlQ4nJej+VVbuFvVKjE6pcdTc2STYhfN
	9nk2WXz8I7FFnYZFVzatgAuD0WJ9rGNL9Gt5R8FBi/5XodPrde28AI5mJfHDXGXzSefynuahayJ
	COvMiiWpX5JohcRw6aT+TcZHNqm4c+cZ8cclDJdw8yPiD4A/pP/wwt/gerqvgkGMSkIMGqSkxp+
	XsG8w+bv
X-Received: by 2002:a05:651c:1c7:b0:389:fa42:b266 with SMTP id
 38308e7fff4ca-389ff1305bemr121187391fa.11.1772557783810; Tue, 03 Mar 2026
 09:09:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122-pmdomain-hierarchy-onecell-v5-0-76855ec856bd@baylibre.com>
 <20260122-pmdomain-hierarchy-onecell-v5-1-76855ec856bd@baylibre.com>
 <20260127151735.GA1699112-robh@kernel.org> <7hjywtzaiy.fsf@baylibre.com>
 <CAMuHMdURxN=kBQHJKnsTVEQPeuB41r5kZy4sgFNqg=U2ynuZMw@mail.gmail.com> <7hv7flrb36.fsf@baylibre.com>
In-Reply-To: <7hv7flrb36.fsf@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Mar 2026 18:09:07 +0100
X-Gm-Features: AaiRm50WKBsQhrWQrTeBP6GpkV839u459YirvJ0kBggs5SGvcv-i6i3nAHRwfPc
Message-ID: <CAPDyKFq0JAKc693d+RrPEBCAH--r+gobf822dQ5Ao6f2gnjRrw@mail.gmail.com>
Subject: Re: [PATCH RFC v5 1/2] pmdomain: core: support domain hierarchy via power-domain-map
To: Kevin Hilman <khilman@baylibre.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	Cristian Marussi <cristian.marussi@arm.com>, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, arm-scmi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: AFC161F4730
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43519-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linaro.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.11:email];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux-m68k.org:email,mail.gmail.com:mid,linaro.org:dkim,baylibre.com:email]
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 at 00:11, Kevin Hilman <khilman@baylibre.com> wrote:
>
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>
> > Hi Kevin,
> >
> > Thanks for your series! I became aware of it only recently, and read
> > it and its history with great interest...
> >
> > On Wed, 4 Feb 2026 at 00:13, Kevin Hilman <khilman@baylibre.com> wrote:
> >> Rob Herring <robh@kernel.org> writes:
> >> > On Thu, Jan 22, 2026 at 05:14:00PM -0800, Kevin Hilman (TI) wrote:
> >> >> Add of_genpd_[add|remove]_subdomain_map() helper functions to support
> >> >> hierarchical PM domains defined by using power-domains-map
> >> >
> >> > power-domain-map. No 's'.
> >> >
> >> >> property (c.f. nexus node maps in DT spec, section 2.5.1).
> >> >>
> >> >> This enables PM domain providers with #power-domain-cells > 0 to
> >> >> establish subdomain relationships via the power-domain-map property,
> >> >> which was not previously possible.
> >> >>
> >> >> These new helper functions:
> >> >> - uses an OF helper to iterate to over entries in power-domain-map
> >> >> - For each mapped entry: extracts child specifier, resolves parent phandle,
> >> >>   extracts parent specifier args, and establishes subdomain relationship
> >> >> - Calls genpd_[add|remove]_subdomain() with proper gpd_list_lock mutex protection
> >> >>
> >> >> Example from k3-am62l.dtsi:
> >> >>
> >> >>   scmi_pds: protocol@11 {
> >> >>       #power-domain-cells = <1>;
> >> >>       power-domain-map = <15 &MAIN_PD>,  /* TIMER0 */
> >> >>                          <19 &WKUP_PD>;  /* WKUP_TIMER0 */
> >> >>   };
> >> >>
> >> >>   MAIN_PD: power-controller-main {
> >> >>       #power-domain-cells = <0>;
> >> >>   };
> >> >>
> >> >>   WKUP_PD: power-controller-main {
> >> >>       #power-domain-cells = <0>;
> >> >>   };
> >> >>
> >> >> This allows SCMI power domain 15 to become a subdomain of MAIN_PD, and
> >> >> domain 19 to become a subdomain of WKUP_PD.
> >> >
> >> > One concern I have here is generally *-map is transparent meaning when
> >> > you lookup <&scmi_pds 15>, &MAIN_PD is returned as the provider. It's
> >> > also possible to have a map point to another map until you get to the
> >> > final provider. The only way we have to support both behaviors is the
> >> > consumer has to specify (i.e. with of_parse_phandle_with_args_map() vs.
> >> > of_parse_phandle_with_args()), but the consumer shouldn't really know
> >> > this detail.
> >
> > This is also the first thing I was worried about, when I noticed you are
> > not doing transparent mapping, but add an explicit hierarchy instead,
> > based on the map.
>
> Yeah, the map wasn't my original idea, and TBH, I had never really even
> heard of nexus node maps before it was suggested by Rob[1] that I could
> use it to describe hierarchy.
>
> But... I'm gathering from Rob's and your recent feedback that my current
> approach to using a map is an abuse/misuse of the map because it's just
> being used to describe hierarchy, and because it's not transparent.
>
> I'm still waiting to hear from Rob to see if I understood that right,
> but your feedback is making me think that's the case.
>
> If so, I'm honestly not sure where to go next.
>
> >> > Maybe a transparent map of power-domains would never make sense. IDK. If
> >> > so, then there's not really any issue since the pmdomain core handles
> >> > everyone the same way.
> >
> > AFAIUI, SCMI is not limited to the SoC, but may be used for the whole
> > hardware platform, so it could control power to external devices, too.
> > Once we need to map a power domain through a connector, we need
> > support for transparent mapping through a nexus node.
> >
> >> I don't really know enough about potential usage of maps to know if
> >> there's ever a usecase for transparent maps.  However, the problem I'm
> >> trying to solve is less about transparent maps, and more about
> >> describing hierarchy in a situation where "leaf" domains of the same
> >> type (e.g. SCMI) can have different parent domains.
> >
> > Hierarchy is indeed something that cannot be described with the current
> > SCMI power domain management protocol.  This includes external hierarchy
> > (your use case), and internal hierarchy: AFAIK, Linux cannot be made
> > aware of the hierarchical relationship among the different power
> > domains controlled through SCMI either.
>
> Yes, the limitations of SCMI (both the protocol, and the Linux
> implementation) are the root cause here.  In case you didn't see it,
> before I posted the original version of this series, I started a thread
> on the arm-scmi list to discuss implementation options[2]
>
> So since this is primarily and SCMI limitation, maybe I should just go
> back to the original proposal of using power-domains-child-ids[3]?
>
> I'm definitely open to suggestions here as I'm a bit out of my depth
> here.

FWIW, I favor re-trying the "power-domains-child-ids" [3] approach.

The main reason is that we already have the "power-domains" property,
which allows us to describe parents using a list of phandles.

To me, it seems more sensible to extend this with a new
"power-domains-child-ids" property, which can be used when needed,
rather than inventing an entirely new property, that would replace the
existing one.

Kind regards
Uffe

>
> [1] https://lore.kernel.org/r/20250528203532.GA704342-robh@kernel.org
> [2] https://lore.kernel.org/arm-scmi/7hecy3h7ky.fsf@baylibre.com/
> [3] https://lore.kernel.org/all/20250528-pmdomain-hierarchy-onecell-v1-1-851780700c68@baylibre.com/

