Return-Path: <linux-pm+bounces-40438-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DB1D022D8
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 11:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6FC6C30FDA6F
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 10:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7D73BB9EE;
	Thu,  8 Jan 2026 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFio8qr5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC643C1FE9
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 09:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767865155; cv=none; b=eXReMFgiJc5ADYKwI+SHHYcn9TK/4Y1p5v63PLe71YNz1gNaLrYJV7Mpdi0gs9fn5Q7BN3mUgz1E3kBz7R8HpQrYb0T6kP6MYFAs+e9lay/R9VkVG8Lkcw/dJfyhjwWzQGa8lJSWfoT1hS7Cwsv0DJ+c3ha1M/R3snX02dQrn2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767865155; c=relaxed/simple;
	bh=Bq9lo2Ohtvj3XIL6dpPA64B4eaxXyOVIuYLGEY645Q8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=JmFePO3CJba1dLcVidacPMRGViTEEYBVWI/l/OSkDEMJO40PG5zJ4O+owC7DYMxoGztbx0ulu5mqKMAyRdGAE8xp8DRmCbRWppcnCaFvs037SASO3Q3RCJo/G3sQIYnxgvQsLvgoJQ7XhSJFe+/UBCMuwm2UL6HzLDFWcqL/f7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFio8qr5; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47bdbc90dcaso21685525e9.1
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 01:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767865141; x=1768469941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=91O35Wu5Tt42VZKwq2kPLdWW5NTRjmE00iaWWCPrcU0=;
        b=YFio8qr5t55ILUuAl7CUBeqYlcv3oNsrKIoT8u2xyLc5ouFQREq/Gqq/WzW/xsHDDz
         ZwvvyhJIjRHbcpPDyLhkEriwNyFdQR4exA3/tTlF1vuaSmGV7CMBu5QC9W8CQf8hHA9m
         NA1GeaOE5LY6LpdC8VayGM3bh4OiBwMfteQAtlRAMeLxkfZa5VhkbQeAAbYJwa5hhCrq
         1IADW9s7s+9e8JNO3qKTrmg5ntNkS+1gvAd2nhV1SAewrx5bQUZlu2OrM1PpaQetSVTb
         yq601RZfjdEJ0Xu433iubx2LcM9tTpDOr2PdEZS8Nn8TnDvB0upSTgbluc28D1KOfyt+
         hyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767865142; x=1768469942;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=91O35Wu5Tt42VZKwq2kPLdWW5NTRjmE00iaWWCPrcU0=;
        b=B09wsQ5MWzUO5SZORi3rNbGE67zTH5evxiMqFD3w95ZCakI9GwZTLOfnaondEtJbMa
         N1WF9c3oPPh4OTO4nABkVhI4IOajsxdBQr11kucu5FiinjZTN5pTBAAnt6CQltVS6HgG
         M5lA15eOFZBWvsb5WYOh6K/jeX9GITzL7U6bUM9u61ZclIuC8qye99bBFchAmFmXer5j
         f4/c7QQWLM5LJwwcQ+nue8lTt1RKt63nKkGU8Omp3UsvJnh1cAc2y7LljqR+0vAR6dSV
         f0OuvvRG/P37d3cEbFPvAFKKHziMwIGCpL/UKkA0hix0nogJnKWZJbgInpSHVn85pH7S
         rIDg==
X-Forwarded-Encrypted: i=1; AJvYcCV+uWmGi88sz6yQbpaGlduuDtCtsGCu4Z+baZTkjgTky4GXYcgkx7DZE1qRlhSU4uUpQYgmLTpt0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwA9+eyULtgWBAVBhpMgsZCtTUTxkKvnFhPh7kRqQxpg+jpTSug
	PKWCi6Gw0VCflRE66Lme+pV7vgt9gTl99k1BB/J34uRY2/oqKDIPqNVm
X-Gm-Gg: AY/fxX7j4i1seEeL5Pq68wJZsRduBZx/IrkjQXWS6K+1cxdOLZ/wC8M0scRoJDP6NcG
	zTkyB4mPxP8BkjDW0CNe5Ij9llgk1X81o+J8XYFOxLB+sludIu2cSKUQR75PKCjiVbinQ/sAYQm
	/2TGfzkogGEjC7HdWAru3GEcOsCHd3GREW6w8MS0vkG19mSLajEmSXzFJuR8bEiTV56FL902Y4r
	6YXTX+iht0DwbpbPy0u5VlJ8M82WlNmByeu5SCig/DmbmfM9roM/ij2JP7Z6/IS8/h/yD7DBli0
	leIburAIL+0CqA/xsmpnbTYMbxMfyZLGP9Itfxp9u6rUz6LhnCjS1a5TaTErEA7836voQl3A5Eg
	xl+sXali0MsU56nLog1KtS5ChKwL+bBti392IYpwHinpwy9lSYKkXdD3gcq0ZKukEPA7CZ3Q9+k
	gJ9TsTk0LdXZWsu4LQVzZhZZk=
X-Google-Smtp-Source: AGHT+IE0ivurfeyw4RGMPF7H3eHa1D98hrIj7ko+VBPF2UVbcwlddpeCKfgvEgdfZlhOZHZZlhrZMQ==
X-Received: by 2002:a05:600c:3483:b0:47d:6c69:bf28 with SMTP id 5b1f17b1804b1-47d84b3476fmr69913435e9.24.1767865141446;
        Thu, 08 Jan 2026 01:39:01 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:8115:84ef:f979:bd53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d865e3dfasm33121615e9.2.2026.01.08.01.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:39:00 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: lukasz.luba@arm.com,  rafael@kernel.org,  kuba@kernel.org,
  davem@davemloft.net,  edumazet@google.com,  pabeni@redhat.com,
  horms@kernel.org,  lenb@kernel.org,  pavel@kernel.org,
  kernel-dev@igalia.com,  linux-pm@vger.kernel.org,
  netdev@vger.kernel.org,  sched-ext@lists.linux.dev,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 for 6.19 0/4] Revise the EM YNL spec to be clearer
In-Reply-To: <20260108053212.642478-1-changwoo@igalia.com>
Date: Thu, 08 Jan 2026 09:38:56 +0000
Message-ID: <m27btswij3.fsf@gmail.com>
References: <20260108053212.642478-1-changwoo@igalia.com>
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

> This patch set addresses all the concerns raised at [1] to make the EM YN=
L spec
> clearer. It includes the following changes:
>
> - Fix the lint errors (1/4).=20
> - Rename em.yaml to dev-energymodel.yaml (2/4).  =E2=80=9Cdev-energymodel=
=E2=80=9D was used
>   instead of =E2=80=9Cdevice-energy-model=E2=80=9D, which was originally =
proposed [2], because
>   the netlink protocol name cannot exceed GENL_NAMSIZ(16). In addition, d=
ocs
>   strings and flags attributes were added.
> - Change cpus' type from string to u64 array of CPU ids (3/4).
> - Add dump to get-perf-domains in the EM YNL spec (4/4). A user can fetch
>   either information about a specific performance domain with do or infor=
mation
>   about all performance domains with dump.=20
>
> ChangeLog v1 -> v2:
> - Remove perf-domains in the YNL spec, as do and dump of get-perf-domains
>   share the reply format using perf-domain-attrs (4/4).
> - Add example outputs of get-perf-domains and get-perf-table for ease of
>   understanding (cover letter).

v2 looks good, thanks!

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

