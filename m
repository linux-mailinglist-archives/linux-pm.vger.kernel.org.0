Return-Path: <linux-pm+bounces-42523-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Hi5ICHijGnvugAAu9opvQ
	(envelope-from <linux-pm+bounces-42523-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 21:10:09 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A10127539
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 21:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34961301017D
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 20:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B9432ABF1;
	Wed, 11 Feb 2026 20:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiWq0ch0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2AC280024
	for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 20:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770840605; cv=none; b=LBg8IZe0g9tu1hTCO7Aeh09YRb+dz4tM8iGVKr/59kUz9CvSzDYvCZp/BhZzCyGG1RoCAyzsjMknQgvmqMQVXQJdpK0duJlmq4O83JxQ1X1GDE2v0JNZASWRjhXccA/HRxttUBQBoNCdObHf+eYT5p4phrPHNjgoPeze3D4S06s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770840605; c=relaxed/simple;
	bh=af9yOjZ0aVVBLT84FOvd+RMYfPJfvzmXxLAi8UqnqnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=abUosvCD08VUH4tyBEfWQFs0s9NLKOgCdg1AhS7YOg6p0+tu4jkoksRAoa3H4U7lYOKdQWwGV2kKuL6AKDU46R36TwNl5aqb/GpeQ3Q5rQ3i9dqAqEzgXCkwHZo4gRoSIDhWT3ePGU8pKX9D1UjomsrsS4WQF48lkQUB91yId7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiWq0ch0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461C7C4CEF7
	for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 20:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770840605;
	bh=af9yOjZ0aVVBLT84FOvd+RMYfPJfvzmXxLAi8UqnqnM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TiWq0ch03vcIpvP25kX6S0hyEgzTcKE0IoWbSowKq5ypsIygagyX7V0FQiLSeHez5
	 1VJgZPdDK5isrS/KzWfvbzp0a5sm2FhDZu0XioJOnBRi2buQMidHMMXnwM6jfAiK3L
	 A1M6Wq64F78iMUpEQ02V4t/2dN1PKxwDSBBqXMKRqG/xhyGXSgD8GRLkAxwEuwwXYE
	 SJKEUyQWIzOEX8dXi5H76/xNACTUSWEdtIyjQ6Y1C+T7sOYtRKGN4nLyX0DLgov6P5
	 WQa7R7Qgl4elgBGWWK5XXWsK39KW6yo0cngs2vBfIFB+ZrJBSu6yaOja0th/66TAW3
	 RP94K+HBqLQTg==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-45f004e7d71so846028b6e.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 12:10:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXRMxBQyTKT6f/hti8Y5SOQG+hAx0LTDjzvbf5MVme5eXnV8+vRDA7Exd+u+arTN8ugGmU0etsaWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOeM9MS/c+fNOMwZvew/SiepiN2u9xA2t8XhFixmslIlh5wJhr
	OigUrI10Z2rIM65YjACfsRNoE1Mop1Xs6HvnbNm7TpRRlDubqdKKO8KXg18gt8InW6JlXaYwJcy
	Gq+H4i0CdER58oJHrstIRDzowUgOjGrM=
X-Received: by 2002:a05:6820:2005:b0:659:9a49:8ee4 with SMTP id
 006d021491bc7-675b1662019mr118099eaf.24.1770840604400; Wed, 11 Feb 2026
 12:10:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205125354.632891-1-artem.bityutskiy@linux.intel.com>
In-Reply-To: <20260205125354.632891-1-artem.bityutskiy@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 11 Feb 2026 21:09:53 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j4BO0tzVK_gYUMku58wEzJSXh7B6STOZiTj_R2mG+xXg@mail.gmail.com>
X-Gm-Features: AZwV_QhFTZeekADF61IKROXkR7-qcbSegoAVszDKiS2gS58MNJcQjRHRwr2r9zw
Message-ID: <CAJZ5v0j4BO0tzVK_gYUMku58wEzJSXh7B6STOZiTj_R2mG+xXg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: admin-guide: PM: Document intel_idle.table
 cmdl option
To: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM Mailing List <linux-pm@vger.kernel.org>, 
	Artem Bityutskiy <dedekind1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42523-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.234.253.10:from];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[10.30.226.201:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C8A10127539
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 1:54=E2=80=AFPM Artem Bityutskiy
<artem.bityutskiy@linux.intel.com> wrote:
>
> Add the 'intel_idle.table' command line option documentation.
>
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> ---
>  Documentation/admin-guide/pm/intel_idle.rst | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/admin-guide/pm/intel_idle.rst b/Documentation/=
admin-guide/pm/intel_idle.rst
> index ed6f055d4b14..188d52cd26e8 100644
> --- a/Documentation/admin-guide/pm/intel_idle.rst
> +++ b/Documentation/admin-guide/pm/intel_idle.rst
> @@ -260,6 +260,17 @@ mode to off when the CPU is in any one of the availa=
ble idle states.  This may
>  help performance of a sibling CPU at the expense of a slightly higher wa=
keup
>  latency for the idle CPU.
>
> +The ``table`` argument allows customization of idle state latency and ta=
rget
> +residency. The syntax is a comma-separated list of ``name:latency:reside=
ncy``
> +entries, where ``name`` is the idle state name, ``latency`` is the exit =
latency
> +in microseconds, and ``residency`` is the target residency in microsecon=
ds. It
> +is not necessary to specify all idle states; only those to be customized=
. For
> +example, ``C1:1:3,C6:50:100`` sets the exit latency and target residency=
 for
> +C1 and C6 to 1/3 and 50/100 microseconds, respectively. Remaining idle s=
tates
> +keep their default values. The driver verifies that deeper idle states h=
ave
> +higher latency and target residency than shallower ones. Also, target
> +residency cannot be smaller than exit latency. If any of these condition=
s is
> +not met, the driver ignores the entire ``table`` parameter.
>
>  .. _intel-idle-core-and-package-idle-states:
>
> --

Applied as 7.0-rc material, thanks!

