Return-Path: <linux-pm+bounces-43736-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wP10BC1BqmlQOAEAu9opvQ
	(envelope-from <linux-pm+bounces-43736-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 03:51:25 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D1A21AC1D
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 03:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40CEF302D0A3
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 02:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89E2366DA1;
	Fri,  6 Mar 2026 02:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaOmjGV/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5AE364E91
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 02:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772765472; cv=pass; b=CrLqCVDvBSySsWDTtJ5J+ks4kE/w5Q1MESerUlh4QNIM+M/NDdTyYHj4e4NrXlNpE8Nw5Qx+k0q9FwByuV3zp//BTJIOzAHArX4RRTPKHd8IsP46oqn/dVeVhJunVgFJViGyOtE2RGeYnxgrHqx/WT6eH6KqpnjeK/4AUVewhfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772765472; c=relaxed/simple;
	bh=le9pM75U+VH6RnwbdxgpjIvWcDTvW+QXlb5uvCpDhYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n9JFr/WPa8PkfPt1iLnTp5DKHGhnJ3o+a2MMgDrLaVq5RnwNMUgHhxWqCatnXPLQFGpzNwzjrLKSPweDIe6bID9dTjpgLIOWA8boJMmx6mRqmVvz21ZGvusqCdL9FqzGsmNPYwOTPTnwjpB7S+hsed5wQY2Mr6YTpsmUtUuE1z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gaOmjGV/; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38a32d36396so11269841fa.0
        for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 18:51:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772765469; cv=none;
        d=google.com; s=arc-20240605;
        b=LggrONYT8AGFYao8c414D58aOp48y5TJrpu3l8AGGMEsSqy3JnyTS7TcUbaiRSHmk9
         FlVaCFdvl4V7e+1L4zMykpyoRV49iodUyH7/H0rhOqHyB51z1wGhYi/l4XY+ZJYJbl8d
         x78Lo3QYpC2lTSQAikJjDpfxT/Nh4eOybzEAZwoDrDapKzk3LIhEAlyjEci09c7iqXr9
         zpDVn0Aruc3lcqQxVMwIf3nmAHeZES+3SvAVU4FxEoDaIlbNKYhVp22QiuGC9Fv6QjHS
         IB4taxGOUVpB3p6ysOXLZJkXeXdR2gZ0Nv0d8iVqYRe6jwg4CybYgpOlwsd+vX8GEYc3
         YfWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=le9pM75U+VH6RnwbdxgpjIvWcDTvW+QXlb5uvCpDhYk=;
        fh=CVAvD12wjOM9VKlLiKL31mnjO3aluQ1A1iKmHzQTF0o=;
        b=e3NRzjN2gaTKfUUT5RfhKJwOgugCfKqSsfPz0346dkTsGNdG5Ie1aWNS6IObEO/dJ+
         CnZ7gYrPPDl+3tXyn1dAuaJnJ9Jh31/2yKdAjpV4QBJmTJuxIR4IuVNdzlQPxnnZUgSZ
         veqo2+2blnI1Cshvhohw63eF0JOb0j9x3K8FjzHOkYFNeAMxHa0BnP+vNcfTidj5jIXv
         veT3v9FsNPU4pAbR+V9kQzgMo7EkQF75ZZcBkTgfv0ERsQnXe4Xw4BR7QN+xn6ZTfHo1
         iVjvp3T2gDGqucWX4wnItoes14SVa1yhm/Ilaea6TYoaKO+cWz/zVV7tpJ7zHcOrcz+S
         7w8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772765469; x=1773370269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=le9pM75U+VH6RnwbdxgpjIvWcDTvW+QXlb5uvCpDhYk=;
        b=gaOmjGV/MnvegMQD43mTuN/tEvcrsygWtZ2F6HcvIctPdB/3LGd5sSytzCJfQURBmJ
         Qdz+hJEg9h78MtBQiNfp/Xf5+WytzDbiE7NR/20JF6yJeIEgiBXzSnp/P7pK5lq2Zoou
         2YUa9OgAdQTIqUfCsBWVfpf0T07yzZmWEqnHIuBuSOGksRKBMhBkBxS//dgvwHq7/cYy
         IEEhyl50PxLsi/C3iIzEMQ6VT+Z3FEZYoxTyS3PEY3teev13aFRjK66WPmXzCAJcUKhu
         xFUyCCPTljaY94be7nNXz7+ogWrMWWBb/4k+RQ0i18e0uIEjuqujpscJkaOrmYv+r1tq
         GMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772765469; x=1773370269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=le9pM75U+VH6RnwbdxgpjIvWcDTvW+QXlb5uvCpDhYk=;
        b=shOWU5aZm6l4YutNrZR7Pt40bc9b70w8z0QDfxJeCgmJZVrXAKavqB6nmhGChy02mP
         92FVGcjURxy8SEH3SBBvR6iAvd8efae6gDtPXXrKw074lhR1VbTs6W7DAjkgf39+hzAz
         QhGXSBvhIgqWnggx4qVqugvvWXtRbcx1voeXx5z7/ZI236Q5Qcj1RaWrB28igpYKn9gw
         cBHlbDXLILYPg+alz5xyYC7cLzdSQl2JcfMvheTJ1uQ5hajSrtnO2Z/f9oM6vPAvvGSl
         ycFZW43dzynk7Gs3RhspWHDy5BciNS8tpgaLioRFQTmtg82IkJAZyWoRxXspOU8CIZhn
         2qWw==
X-Forwarded-Encrypted: i=1; AJvYcCXFvxWTWCCh9ZY1oJJxx6DmFuswR4QBwLhEOrmHuU/SFomoZNbtQK2gpSUes2l74iTya65XSOyfug==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd9eUUcs0LmXQLUZ9YLUCyIdtL4ODTydJpJo/SIAQ56NBru6e9
	BRIdRA8tsJXV/NPGpBO/aUQC+zpAKLyKhx6MmZljq2HzztHNAUwzfKNOgcYnihjAOvbaHWx++y5
	FQCV0Mi/x94+xrNw+zUFZwog9XUL7P9M=
X-Gm-Gg: ATEYQzwJkAVZ6SYATS1vDLS3WJfuWR4AzjJNYmkVEr7H1owPW/ai9TT8eIjKQhwSofh
	LVDHhrA6HYFqmCWfPediSMPjhRfcDbPhSarDWoyS3406v/J2alZl7WmaxnZadY4BdVFr9JB5sFF
	Gg9TNGIMB7uzuQaP9z8dCAvgfpdb5iQZF6abWXMY2gT5iSIv13vabwZzH2bQHzDC6Z60XDy2CeI
	tL6D8plg+D/3E0Hbg0qyqctoLf22Wr/bb8moVJSb/JT+HdtSRNS6Hs3UVcxTQ8XhMS6Rr5ewhE+
	Dw267X8Nf8RMEouRlihbBGZ7p9+dS0o2N+YnkMH2hLsMhMM4MjJWwR7ZNhVqY2ePU8gyH59Q
X-Received: by 2002:a05:651c:620:b0:389:df67:64ef with SMTP id
 38308e7fff4ca-38a352a4a0amr11338661fa.20.1772765469411; Thu, 05 Mar 2026
 18:51:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306022406.760-1-ming.qian@oss.nxp.com> <CAOMZO5BP2aLD+a1r7hVd3F4Qvfovxb8PgQfzcVRKknBHWYBmtg@mail.gmail.com>
 <61e260e0-4544-4c51-99bf-c4815367fa94@oss.nxp.com>
In-Reply-To: <61e260e0-4544-4c51-99bf-c4815367fa94@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 5 Mar 2026 23:50:58 -0300
X-Gm-Features: AaiRm52ueFUXaqQfpowdXyDTPs2aKgG6aHElJW7IWO6H3_-P9HAhh7hH09TPm6U
Message-ID: <CAOMZO5AYRWBykSdvogO0Ea6JidjgY_h5drnBpcDNFrU_oo_L2Q@mail.gmail.com>
Subject: Re: [PATCH v3] media: verisilicon: Fix kernel panic due to
 __initconst misuse
To: "Ming Qian(OSS)" <ming.qian@oss.nxp.com>
Cc: linux-media@vger.kernel.org, mchehab@kernel.org, hverkuil-cisco@xs4all.nl, 
	nicolas@ndufresne.ca, benjamin.gaignard@collabora.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de, 
	sebastian.fricke@collabora.com, shawnguo@kernel.org, ulf.hansson@linaro.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, m.felsch@pengutronix.de, 
	fra.schnyder@gmail.com, linux-imx@nxp.com, l.stach@pengutronix.de, 
	Frank.li@nxp.com, peng.fan@nxp.com, eagle.zhou@nxp.com, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 80D1A21AC1D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43736-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,xs4all.nl,ndufresne.ca,collabora.com,pengutronix.de,linaro.org,gmail.com,nxp.com,lists.linux.dev,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[festevam@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,nxp.com:email,checkpatch.pl:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 5, 2026 at 11:47=E2=80=AFPM Ming Qian(OSS) <ming.qian@oss.nxp.c=
om> wrote:

> > Drop this change. It is unrelated.
>
> But without this, the checkpatch.pl will report error:

Please do this in a separate patch.

The goal of this one is to fix the kernel panic. Don't mix other
changes with it.

