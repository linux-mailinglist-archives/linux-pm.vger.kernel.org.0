Return-Path: <linux-pm+bounces-42464-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DLiG39ji2nDUAAAu9opvQ
	(envelope-from <linux-pm+bounces-42464-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 17:57:35 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D76AF11D7AD
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 17:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1E0630347B5
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 16:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3EB322B88;
	Tue, 10 Feb 2026 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ol2ePfby"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0C831ED8B
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770742652; cv=none; b=b8w0YST2X+RMJF5W3g57G7u3uqhzNS/aYEw6ywB45RCPb01r/5C6svkGf/oRBBRIfF3pt7tASufszVZR69ijUYYJwSlXbFIwaTetbJKrg/ogLusFX2QK3wuAIADHyBrR2ShspiiXrDml+3J1Yk7n8WpKbYUCbtgOoQT+4gQUJKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770742652; c=relaxed/simple;
	bh=OFnms8PR8wjP0zRa5YZfOWeSHn09AqW4idkB6vN7oTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/lIltW8tse31TMOcOsPvSpzRHc9gqyA8bLFbQzhjv8aKQ1APKgqxaGPONyujMhjutQbB2w7pCHkQrW9A2nzmd1ynlWgr/iWSIon+qea6ihomA7QOMvhGsB9MQTUaizu7/pPWEVezKaL8xM4l0IHc97uZ0L66MvTHM0f3I5+dQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ol2ePfby; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50756C116C6
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 16:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770742652;
	bh=OFnms8PR8wjP0zRa5YZfOWeSHn09AqW4idkB6vN7oTU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ol2ePfbyGJGTIYPB6w0K2bWNvgHkpCA4gbGdzmVfuQJPW87HKyQ0UV+GgDTSeqh6q
	 s78FG3ea0sF+xwx8XcRij1OJYjBqO4V+zarP5MR1k+ceJ1+qpzEmd1CrlW+0jrk49a
	 lYcC+nRNSzXGgn3O4tj0E/YD9sITogHiXDOGs9vSX/gyqndgK6ex2iZwdGptlVipmR
	 EZwz1yhIpfuxdTclGjDAe/gkxdfxCi8GDuNSwGPLllYWxOLFeUv/ocOCcJ6ObU0lzK
	 N1/PnhwzyN2II/PhTYXSvmhlX+yGjOk9o1yHrGEq7neNrJcOwUbXpie2DS/FHXfA9n
	 JrMS26uxg8+ag==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4042cd2a336so706597fac.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 08:57:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWBeeU1xEw2GVdHnSxpf4/37vHmhJzkBarJfD1Ne8UNjfq/eAn4QIP9shng+GdqfOsX57qrJnUOyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxB5nJ8paImXZ9wosERJ/gc2QKG5la5DSSk4YDF+hv4pD6rDBsu
	UR3BY8ERmyllCZLfSH/3srGV2I2d1gfO0NOrpU9OoMw9OZwsYxtBXOv/WcLoskv+sMeR9BOTRhr
	GJPT7ivwdbe8cSJ6Xjdh/97AhivdVgn4=
X-Received: by 2002:a05:6871:3747:b0:40a:5a07:3598 with SMTP id
 586e51a60fabf-40a96f947f8mr9204363fac.36.1770742651431; Tue, 10 Feb 2026
 08:57:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205-topic-lpm-pmdomain-device-constraints-v2-0-61f7be7d35ac@baylibre.com>
 <20260205-topic-lpm-pmdomain-device-constraints-v2-1-61f7be7d35ac@baylibre.com>
In-Reply-To: <20260205-topic-lpm-pmdomain-device-constraints-v2-1-61f7be7d35ac@baylibre.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Feb 2026 17:57:19 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jCLSz_SeBKHwXOxRrwXvUBXiovXnQa4qx2nwOMgkuNSw@mail.gmail.com>
X-Gm-Features: AZwV_Qg1FS_IwfkTx_0WMsDjuI_TC2iNl8qsZIhS_sJxi3-Um8hExBYNhaAfGGs
Message-ID: <CAJZ5v0jCLSz_SeBKHwXOxRrwXvUBXiovXnQa4qx2nwOMgkuNSw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] PM / QoS: add flag to indicate latency applies system-wide
To: "Kevin Hilman (TI)" <khilman@baylibre.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, 
	Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42464-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,baylibre.com:email]
X-Rspamd-Queue-Id: D76AF11D7AD
X-Rspamd-Action: no action

On Fri, Feb 6, 2026 at 1:30=E2=80=AFAM Kevin Hilman (TI) <khilman@baylibre.=
com> wrote:
>
> By default, the QoS resume latency currenly only applied to runtime PM
> decisions.
>
> Add new PM_QOS_FLAG_LATENCY_SYS flag to indicate that the
> resume latency QoS constraint should be applied to system-wide
> PM *in addition to* runtime PM.
>
> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  include/linux/pm_qos.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> index 6cea4455f867..aededda52b6b 100644
> --- a/include/linux/pm_qos.h
> +++ b/include/linux/pm_qos.h
> @@ -37,6 +37,8 @@ enum pm_qos_flags_status {
>  #define PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT (-1)
>
>  #define PM_QOS_FLAG_NO_POWER_OFF       (1 << 0)
> +/* latency value applies to system-wide suspend/s2idle */
> +#define PM_QOS_FLAG_LATENCY_SYS                (2 << 0)
>
>  enum pm_qos_type {
>         PM_QOS_UNITIALIZED,
>
> --
> 2.51.0
>
>

