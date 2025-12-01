Return-Path: <linux-pm+bounces-39009-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF529C98F7B
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 21:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CE013A3881
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 20:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49C42517AF;
	Mon,  1 Dec 2025 20:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcEpYaLa"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD00248F57
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 20:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764619878; cv=none; b=BNTA/Z5ifj+pfWuyVSI8nOABPsTSbI0HHZoyGF370lAwBdDxoDu29rKvw6D9CWgbAeSc4S4531Fg7bW3knZZXtCLqCkQPlJG9X/RX2DJs5WLBrPkpTEWJILjSu7mQ3OWHRXOuutVRYUSSiKIv09akqLZZ2MDtZomt+1Tsaq87DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764619878; c=relaxed/simple;
	bh=eMYnOTk/xxeyBJBecDp0ak8l4wVpEx4pPvtWXIoQRio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q+oAuTqJkeAHIjq28BLMIqxgqjAxcWtW1z7ZPf0J1Uo37aQIB0C1Cxbjnbf0feGRD1hdjoYExkc2I9GKM2/1sNZa3Nhzc/+rKLV9vOCOWwjONYcKs6hnXv9r4Ra2vRd96S64nlQMvw56LSj9ljtn95NgpDxOgls4JXMVB3g75zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcEpYaLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A018C4CEF1
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 20:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764619878;
	bh=eMYnOTk/xxeyBJBecDp0ak8l4wVpEx4pPvtWXIoQRio=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CcEpYaLaR8KaJ1j+GwnGDAbvrGBK9I1Z6zf8cGRzIgDzTC7Ve1ljzHtxc+WJzREga
	 K2u5Fb/oGq5uMV+W3V7Vv9EweCT5JHlWo0K1cUS0yxYwNog4nLNxV4KhImHlGSrAwh
	 2mgpl+Z0IA0XOyBi5mq7yahzBlgMsoHg8kWKWJ0WFpJRppOqj2Xcyssemg/aF+n8Tx
	 kzE+PME376H4Khf8IeK3NOkvYHc7OK/q9/pNHkkJxVu8EJ3WV/31xRl+uMkPgSP38X
	 ch3+m+1/DqyyjZjZcvF8A1GN57vVSEuzCajVhB01HrEvS2mooupHKdx6Wfkeek6t7G
	 piAk9OqFVzbDA==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-45066bee74aso849409b6e.2
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2025 12:11:18 -0800 (PST)
X-Gm-Message-State: AOJu0Yy9yUVYKIsrReesL4NSoZX8A0R3lsDBaBhLwTsaNRM+xj+RIZ3R
	CpsFVH30qolHY2UzygQg1NshgfIgO14iTVTZx99fV9FeZnH7H7pG9jQjiiChn5Ln/VHDz/bRWvB
	zDSuuJXm1o7M1Cg06UK9vvOsr+V/WmPs=
X-Google-Smtp-Source: AGHT+IHD3znwNZOLYRc+eyESfS2lsSI6tWfe20QoXvuwlzwsfGML2nfozO/l0y8uIGeicIrYTTcXH9OD9RImEoQXxsQ=
X-Received: by 2002:a05:6808:2f15:b0:450:caf8:eba2 with SMTP id
 5614622812f47-45115b19735mr18370426b6e.57.1764619877540; Mon, 01 Dec 2025
 12:11:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118155813.533424-1-darcari@redhat.com> <20251118155813.533424-4-darcari@redhat.com>
 <CAJvTdKmt+3i+TjbYSa--=uS22q1ZgEQuferNhCxKVK_G5Lx2jQ@mail.gmail.com>
 <b2ff2579-0d19-4648-9411-c02133c28c1d@redhat.com> <25d6584f-7763-4b6e-92da-e8f1e31ea3df@redhat.com>
 <CAJvTdK=g191mjf3uhXTemZCfoc2iQWSE0n8QtFewvMmCbEojgg@mail.gmail.com>
In-Reply-To: <CAJvTdK=g191mjf3uhXTemZCfoc2iQWSE0n8QtFewvMmCbEojgg@mail.gmail.com>
From: Len Brown <lenb@kernel.org>
Date: Mon, 1 Dec 2025 15:11:07 -0500
X-Gmail-Original-Message-ID: <CAJvTdKnBKcXJV5az-2q1MF8b6PU6mxVS2YETgn+OWUKBfOSuZA@mail.gmail.com>
X-Gm-Features: AWmQ_bm8tu3dzItUej9ZX8bmtETSF6YaNsE9x6ltBlS4su7gx8o-IR80Y49I-Sc
Message-ID: <CAJvTdKnBKcXJV5az-2q1MF8b6PU6mxVS2YETgn+OWUKBfOSuZA@mail.gmail.com>
Subject: Re: [PATCH 3/3] tools/power turbostat: allow turbostat to work when
 aperf is not available
To: David Arcari <darcari@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Something like this?

diff --git a/tools/power/x86/turbostat/turbostat.c
b/tools/power/x86/turbostat/turbostat.c
index 5bc47ad5da09..4a847e7e9c65 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -8530,7 +8530,7 @@ void rapl_perf_init(void)
 /* Assumes msr_counter_info is populated */
 static int has_amperf_access(void)
 {
-       return msr_counter_arch_infos[MSR_ARCH_INFO_APERF_INDEX].present &&
+       return has_aperf &&
msr_counter_arch_infos[MSR_ARCH_INFO_APERF_INDEX].present &&
            msr_counter_arch_infos[MSR_ARCH_INFO_MPERF_INDEX].present;
 }


On Mon, Dec 1, 2025 at 2:53=E2=80=AFPM Len Brown <lenb@kernel.org> wrote:
>
> > ...add_msr_perf_counter() returns -1
>
> good.  and then add_msr_counter() succeeds because...
>
> > rdmsr returns zero for MSR_IA32_APERF and MSR_IA32_MPERF.
>
> Your patch is a good suggestion -- though it checks for APERF only and
> not for MPERF.
>
> We already ran CPUID and cleared has_aperf, so I'm thinking we should
> be heading this off earlier.  Let me send you a test patch later today.
>
> thanks,
> Len Brown, Intel Open Source Technology Center



--=20
Len Brown, Intel Open Source Technology Center

