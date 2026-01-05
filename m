Return-Path: <linux-pm+bounces-40184-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0B2CF343C
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 12:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7305530639F4
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 11:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C582C33121B;
	Mon,  5 Jan 2026 11:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VL8qm6eH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB92433064F
	for <linux-pm@vger.kernel.org>; Mon,  5 Jan 2026 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767612454; cv=none; b=Gl0YgtAAmdZKMcYrsycWs3qW2oUjqeKIRvwnp1WADmFipq1HZrOfO8M43BJYXLLQtdxNXnfA/MK6zvCMHCTSD0lh7ADEqQwqFxi1oq/VKZIHoFzsmhr7Wg1BpmeaZtWGA7ruzkfiGyP+55wE7JporRXgCZ8XeNdlSiBp5Lw78FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767612454; c=relaxed/simple;
	bh=Go+GAYzO0jgTKcc48Myrg2Pj0BaCXr+2m/+CGE76n6c=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=fNbD+GqIeDYbVBS8Mp/ClUCeAw50SOzm+7uw3KZHNR32QnBzNz+P+m1jW4sXdfhlJaieGFcd9H7QQJMZszxQFajY2QdbS0hlal/OWzahsxCd/C9s8BKG8QUlxaIvhCFF+FWs8nXG/cOASHYpF8bVi5EciQ5wvQfbr9eZQKIQ9dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VL8qm6eH; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43260a5a096so7799835f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 03:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767612447; x=1768217247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j95TD1ZmtU4Apnwzg09U0kNwpICIT3BxQAw/HHzh+18=;
        b=VL8qm6eHO80/CL3xLajJ/0K73Rm5sil51ejACLf1u1FBCS7IHgblbisukbmtPKMxZe
         4nZVJ+2wVvCtGMuChE81krgIJw0xAJ1/cOXGtQxBEHCthzFAMCdH67GdYpEmVWgxSnL4
         8U3TLBeLQStbNUIiT48gC8XyyeJr4bF9znvtmyf2D1XHdrlWnP6L7p4vaN9o3X1d+/Yh
         vNS4pr/X8eB2XGNtJhVj556T7dU+r0gLZATqK67SciJx1ee//z/qgUfGXOH8Nxvx6yYK
         jYm7y3GMxCqzZ6YgzzlOWawF5I5h0L5FIEp34tV/XximpcSBGP7Q63yi8Y++Focv6gMP
         IFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767612447; x=1768217247;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j95TD1ZmtU4Apnwzg09U0kNwpICIT3BxQAw/HHzh+18=;
        b=Z3E4G1DGfH23i1oNbgZzuj7g9mzUbMVr/gBT87QtoBxvuobfnl9Axn8fXVuvrUk+FX
         a5scZ00iyQpNurMbvT0AARH3yzOgG+K+a9HoI+fuYOg8a1xTA/tDieuciidjDDCqLA1x
         u9wBFF6zCWAnqIiI75lmo4Jxw7WmSWCpjtAzHPHvRahFIhhHp30GCsZIz960fWtaI3CX
         QGPmijFC27nABko9Kujjk/CiHfqHp7fu4oiFnGzlloNd+MPQ4MmUKBemPo4CnCp30yrB
         G5/C2C/OagkxGj1nDXDYA5p5p8+PO5+ivrQIkqO/CvS2D8HHRiC1GzqGnTKd2q2yA2CW
         Sr6A==
X-Forwarded-Encrypted: i=1; AJvYcCUD6c4nNSkzzXQ456rIrlXtne4U+iLIAo/TS1NPkQY4yX6PiLm5jp6URmr0ywic55pPYoJITuKi/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIJTmh4XSU0BXcwYacxFU7Qclp5Ovc9tDiQagBJC93OohKiKUS
	q2CPpb5G4WE6vrOtXNiAmzhI7L93ssO+/QlMqVg3NUsqYabvtvGyr+0H
X-Gm-Gg: AY/fxX5dxMpv6F/0sLcF+WxVDBflBNiSFK6pJWcP/j/vBU6ANHXTMPmgtG27r9C0JBu
	hJgGyogKjnL7thQgdQ2bwpkwDYg+49by/8pTL1+zT/VBviLibS9JSyCe0laEoyXdJN5NTk8a/sS
	YxtDlzNW3vq+wpqXWWz/0f+6OXXaSFwrNeQ24+zUlZ4sHwJeWwciKeWRYBzqBxBwdKay8oVbzmS
	AOXA3Imds2gc7ZcuL4iVh9oJivGzDHHZXCd+L1AXipdLAWsuIiTyis/dZXaFMAEkWVzNdytSL0L
	ZozF79hvqUSuDZo4xx+HU+PIIIxmQHsRZd6JfaKFFfnGxo8+mezYWBfv8P5+AGE1gBCG0ZSZjVF
	hHqlEs9VuuWBBL3cgafZDiIMPk3gg5Ti8FNjZZoWj9Pd0Xq2Y07Tt9QAaoHr0QbKXYdUf6KVBr1
	pfGovg4fbU1Z+4w/HkR6o28Bi5EATsrVHDDQ==
X-Google-Smtp-Source: AGHT+IHKBRGJ6Q+jIIfyxjpoPEvNxTxw0yHBFy5IfbUyV2HSAIYXiI1jCB0lNf27X4mjsLq2EPc8PA==
X-Received: by 2002:a05:6000:178e:b0:430:f7dc:7e96 with SMTP id ffacd0b85a97d-4324e50d6ccmr65245024f8f.48.1767612446482;
        Mon, 05 Jan 2026 03:27:26 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:fc71:3122:e892:1c45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea830f3sm99180248f8f.22.2026.01.05.03.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 03:27:25 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: lukasz.luba@arm.com,  rafael@kernel.org,  kuba@kernel.org,
  davem@davemloft.net,  edumazet@google.com,  pabeni@redhat.com,
  horms@kernel.org,  lenb@kernel.org,  pavel@kernel.org,
  kernel-dev@igalia.com,  linux-pm@vger.kernel.org,
  netdev@vger.kernel.org,  sched-ext@lists.linux.dev,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 6.19 2/4] PM: EM: Rename em.yaml to
 dev-energymodel.yaml
In-Reply-To: <20251225040104.982704-3-changwoo@igalia.com>
Date: Mon, 05 Jan 2026 11:25:09 +0000
Message-ID: <m2344ki9nu.fsf@gmail.com>
References: <20251225040104.982704-1-changwoo@igalia.com>
	<20251225040104.982704-3-changwoo@igalia.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Changwoo Min <changwoo@igalia.com> writes:

> The EM YNL specification used many acronyms, including =E2=80=98em=E2=80=
=99, =E2=80=98pd=E2=80=99,
> =E2=80=98ps=E2=80=99, etc. While the acronyms are short and convenient, t=
hey could be
> confusing. So, let=E2=80=99s spell them out to be more specific. The foll=
owing
> changes were made in the spec. Note that the protocol name cannot exceed
> GENL_NAMSIZ (16).
>
>   em           -> dev-energymodel
>   pds          -> perf-domains
>   pd           -> perf-domain
>   pd-id        -> perf-domain-id
>   pd-table     -> perf-table
>   ps           -> perf-state
>   get-pds      -> get-perf-domains
>   get-pd-table -> get-perf-table
>   pd-created   -> perf-domain-created
>   pd-updated   -> perf-domain-updated
>   pd-deleted   -> perf-domain-deleted
>
> In addition. doc strings were added to the spec. based on the comments in
> energy_model.h. Two flag attributes (perf-state-flags and
> perf-domain-flags) were added for easily interpreting the bit flags.
>
> Finally, the autogenerated files and em_netlink.c were updated accordingly
> to reflect the name changes.
>
> Suggested-by: Donald Hunter <donald.hunter@gmail.com>
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>  .../netlink/specs/dev-energymodel.yaml        | 175 ++++++++++++++++++
>  Documentation/netlink/specs/em.yaml           | 116 ------------
>  MAINTAINERS                                   |   8 +-

YNL spec and MAINTAINERS

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

>  include/uapi/linux/dev_energymodel.h          |  89 +++++++++
>  include/uapi/linux/energy_model.h             |  63 -------
>  kernel/power/em_netlink.c                     | 135 ++++++++------
>  kernel/power/em_netlink_autogen.c             |  44 ++---
>  kernel/power/em_netlink_autogen.h             |  20 +-
>  8 files changed, 384 insertions(+), 266 deletions(-)
>  create mode 100644 Documentation/netlink/specs/dev-energymodel.yaml
>  delete mode 100644 Documentation/netlink/specs/em.yaml
>  create mode 100644 include/uapi/linux/dev_energymodel.h
>  delete mode 100644 include/uapi/linux/energy_model.h

