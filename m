Return-Path: <linux-pm+bounces-41544-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDfQJ6XLeGnBtQEAu9opvQ
	(envelope-from <linux-pm+bounces-41544-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 15:28:53 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBF295ACD
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 15:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C1118300D0C8
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 14:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948D735CB90;
	Tue, 27 Jan 2026 14:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WXFR72v6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F3F35CB68
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769524096; cv=pass; b=cfXOpNOMNYkZqMxX03sizwweSYQ0QIAmKH6B2XtVgQ2ZRYGtf/9SXk0N6MOY2RRbJx+1pISEDL31/Ug0IZjlH1I+YsPuxT4VdoSMNc5KUGzViYbee0nDubMH/h4phc5wF3TfqTDuqAmZ/79+H0k9iTl2/x3N02yvacJgF6p/XAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769524096; c=relaxed/simple;
	bh=6VTh8I8I/+80MvDWVLLWs00A68sVPECFn/rmyP1ZpIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bk1YUktsLxS4IwP0gGFJrpkjQYAKwZdf02E5baisJjFodYmAD3Aci2cAekNSqZnK6Wlh0FrZYs6cns/ZcE3vuQLrtnIM0Byi78G8Ol5nt0/+m/O4HB3tFW3tUrBTUOCiUihwxG271R6Y5reLr0n/ovq6wx9W/ltmyNDdiQwgpvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WXFR72v6; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59b679cff1fso5626968e87.0
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 06:28:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769524093; cv=none;
        d=google.com; s=arc-20240605;
        b=QdAXdWG4zGLJ4WBIn2pbxDyoUwJ5OMHJRJeNlCiWLAWiQr4OS3cAGuPoWdIJwFdDCz
         u+2Jq7oxkGgz7+ka1kOdob+pgO7ft/eorKrmxSC6ztsF/zYKLpIhPhqOUa9exnIxkZxS
         dSCIjLd8sMTgdx6J9oz5w8ijEeCIcykoXvhCPblzD1Ta0IvQjsqwpypPGw/pEvYGYH8K
         F17sFo7SFWC4TxvHBzDOqEFOkVR9G5LHXihmjy0wdeWl8kUgj1llpiRP+/G0GcUaIMYO
         xwpuPjTg+qjZO4GPjKajAI8ioRgK8XTeZsjPghR6QdF+UimBYdOcDGLeK9Q7yB0LdXe1
         +b3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=t0ESGWx9fnjgOGpazBly9gTrnFG61Lpa6kpmy1XSQPg=;
        fh=7kI20OEl/0HoyjEvB73aCDvwyS50zDVFiPtQ4dEniuc=;
        b=Au+c5xK1oR0MBmtkb8MZqaxxAbPAtTeLaTi4rMROp2iOGYwghWXhSRlS/zWgAeJXB8
         i8eSnjkyTo+VcXoXfwstYYqfYQolIK6mIc8FMcyjHOwPXe2Un8W90DDfQhPVqL4LjuIF
         QN0ueXR1uX7zY4EHgipGfRpRM5Va7SAMiG9GZ3Fx66ROiwF3b/2jtYFD24JeSprdDkCt
         bByBGOgHoNmlaX7K6O6t+y8F/Q0oVltCOCC0tID0CwChhRFgDlMmdcVpzIwSaaHNImsl
         7FctMo6efmhgnuJgLKDmeGJowIhFM/ncxhabGjU03BmOHt0GyBUBy2pTO3fG+2AXzmAF
         iR9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769524093; x=1770128893; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t0ESGWx9fnjgOGpazBly9gTrnFG61Lpa6kpmy1XSQPg=;
        b=WXFR72v6XJ+9gTe1HmAvpd2IIoVpsILzQ5nVcPrsJRV3+JQE0tILpjUWw4wAhI5/9S
         7h2uMVXLt5iJtpXUlmRHP+AEqruIiAgvAma2D1kL3zRdmlWs9BY5C4JOfIzgspeLWwev
         AHnsG7Wt8IsvO0VceGlxlW16mqDb+C7A97O6gdJeZR2T/PneTCKUN+o5oXdsRlBpI3IN
         V3ltzFaxnB48l7p4Hl5dVVO7SmE/eZGASR3XAA/PyxnkIJsoqvP5OKgeCmvAwcCeWoTC
         yaYTjSOYJTxIiC0vyZfUuzW174moZ9NuYEF42oXzYsAvk7lWQJA/seEL7jGPxDgRkMSE
         KDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769524093; x=1770128893;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0ESGWx9fnjgOGpazBly9gTrnFG61Lpa6kpmy1XSQPg=;
        b=I49TcW5DpZ7Xzs+TRPVualRQe5trxe+4oIfQnKM2ok5Ijisrw0YXdQzIej1IWu+kN8
         KLsj3N2xULSNTULWPXXu0WIqh2UE6k/VxZEb7zDa0YiNA5na2ikKnXLnXoNd7mYal28b
         WPvFBrXrj3QMoWp+ueCigI+LbVPd6sbw3fCFpjDctuR1zWFHlYg0CfczlSUTZ3k4LQgz
         Odz+efl2nc7ZNCLy2Q3L6QPGitodsM4JugBoWxe3AARfgAaz0i/ShoqzjbIYNf5+YHs4
         5CY35iLXXCCl4WUIFwsCmbtifg0mlQEkvEJLxqOB9aE2TzpA/cvzoGRljBV2EzdCeuQI
         77bw==
X-Forwarded-Encrypted: i=1; AJvYcCWBUsLu7goMbia6Qbwl0vQ+El+HkV0zfWT/0fwxe0xJ0iiZYqKnbEAk5SJUNwXqE8mpFzXMm5aMiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuwxQoZEuKlplNc3LpzuQO35+/PAifyUIQE6dg+sd9AomUzSLR
	7stVqttmbisVDrZeLuOzV6ujn3hY8zoXyYr6gCyWVWekg4Cq70pcIE/JiNQa7RXXLmFbgU28gv4
	Ia+4j/XzF4lSTXV92SGsLCbkB5iqyF1tvCWgE+jWbvQ==
X-Gm-Gg: AZuq6aL+swzPrF5LJtnJR9tfdjVCoK9f+Befnunfvso04C0Iq2r2Xnnht28QKVF0pdY
	65PzyF3dPkP1IXHIDwXJV2gE4VAckihqUiTXbbFkiA3dx8N8i7edyxjdFEv93wZN3g2/0fcBo/M
	LUiqMq0hGiZSLdmyDIcehXjt/DZTKZ50rzbjhcvpp5fVPB44LJWUw7oet6OjJjvbkwA2RhSHVcR
	aLTsOmhhIIvJVRAbN2ypAwW+YUDMgfLsNd4Sb9ijo5kHTtXSaGOREDHKoEUdJSEHvW4pPro
X-Received: by 2002:a05:6512:3b11:b0:59b:9f59:c15 with SMTP id
 2adb3069b0e04-59e0402c9afmr783463e87.38.1769524092831; Tue, 27 Jan 2026
 06:28:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119143121.161583-1-ulf.hansson@linaro.org>
In-Reply-To: <20260119143121.161583-1-ulf.hansson@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 27 Jan 2026 15:27:37 +0100
X-Gm-Features: AZwV_QiV6UzbLAUygIz0HCFmYZw0hqyGypxLtdRFMO8HbScVt9PcTFuNfQK6yDw
Message-ID: <CAPDyKFqKTBXpXBqkryc1_7=nXMm2Wr+FGuDHZq-Pm4+71DM7nQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] pmdomain: core: Extend domain idle states debugfs support
To: Ulf Hansson <ulf.hansson@linaro.org>, Dhruva Gole <d-gole@ti.com>, linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41544-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linaro.org:dkim,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3EBF295ACD
X-Rspamd-Action: no action

On Mon, 19 Jan 2026 at 15:31, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> This small series moves around and extends the information that genpd shows for
> the domain idle states in debugs.
>
> Please help review and test!
>
> Kind regards
> Ulf Hansson
>
> Ulf Hansson (3):
>   pmdomain: core: Restructure domain idle states data for genpd in
>     debugfs
>   pmdomain: core: Show latency/residency for domain idle states in
>     debugfs
>   pmdomain: core: Extend statistics for domain idle states with s2idle
>     data
>
>  drivers/pmdomain/core.c   | 59 +++++++++++++++++++++++++++++++++------
>  include/linux/pm_domain.h |  1 +
>  2 files changed, 51 insertions(+), 9 deletions(-)
>
> --
> 2.43.0
>

FYI, the series has been applied for next!

Kind regards
Uffe

