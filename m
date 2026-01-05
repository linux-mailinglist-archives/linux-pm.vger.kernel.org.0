Return-Path: <linux-pm+bounces-40182-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDE7CF3421
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 12:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24F96305EF8D
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 11:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA61330B3E;
	Mon,  5 Jan 2026 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GT8WVbMX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B7D330B09
	for <linux-pm@vger.kernel.org>; Mon,  5 Jan 2026 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767612448; cv=none; b=Q6+7BB131DiZhyXyjrxLY+aUUyS5HcFyhxs60f5QB9rPbDL5SrXTIuCFnAL6CRqdp0egg9dMF1KyzS8+PrQkeVSd7bLw3IWq2cSShor3zyMrsvr8P45K/f6ltSDT0FblVmnUVgiMYUXhFvfscBoI4ewx2ZLMnVXmeCELf3VwBOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767612448; c=relaxed/simple;
	bh=VUXdc9hwk0T2er9DTckmrZex4qeCTOgDcVRoChu5qdY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=KqA50IO8hOXA8SqC8XSdzVODd3OOaLKmixqQTJrKB6iFfPRBz6JQOHIN8sSP+K1cfIeJiuQGhGE8bSqwOoMe5SCukFJXBmjdlh8KhMKDEfiL380gFdts6Qx6WfF6S179uu0Lexji2X95EmACGFbKaDrLsGbJNjnONs4cKlBoBq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GT8WVbMX; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fbad1fa90so11606893f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 03:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767612443; x=1768217243; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2qHDzkZJACXcp+eQuf4jUc4YyVkIXXCNoOh0gjbwoPI=;
        b=GT8WVbMXD21yXh5A1tsJXqAr0ScK130QqyKqO+2dPqIgMxTD/Frhr1f+s+nnimJ6Kv
         bLsObw+XWNwICqT8lFmdv0l/yMEG6uAInIEd+rt1+IZ3qeQaIcUuTzBpdvGKKCYJMGDg
         MXhA5GoI7c0KwTP3qZl4nB8nAWXj+1xsJa1EgYNfRhk8VXZQTF1Y7pi/9t8Jtaq5u9K5
         uG6KIt/xdc3/t9IjzgOzlfMKB9DleqOCcAPJxE5kKRhDe8K9m7ic46iwr2u3ocaOVjqc
         KJMRfl7W/FjlSyL+e/AkVd8fD6WnQu1d3egnQt8Ccyiad0RoWF6KZRmtJYioBakDHJDf
         cG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767612443; x=1768217243;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2qHDzkZJACXcp+eQuf4jUc4YyVkIXXCNoOh0gjbwoPI=;
        b=QwBYn5Y9jjqgZU+h11RVV6rg0TIW2ZkwWRxngJdMkcGBKcfc8mK3z0EheJfj1PPN2d
         qiQ3F8Q82j1UqCoEtT9r/oaUegQcUpCUfE7D+H2POLuo3lzd+9W6DmCQ1jo+XHSs5jIp
         OX1urrCYZPiSfq6RpYZ2VIW9DjGcq9ji9R3KLH8519h0qhvDZK2XrGjNEzpyirmz633D
         jgDQtejiSLtn1vyr1i1Mep2V6cVVG9dh75jjMTryobje1WqBaY2jOdm3JqkqyIplz5mv
         PJCAqAQr7FxjqbZvmv8L4WteF6KtWrvnVvXAH3Nh2CrWybEEJljkJhPGRppbuJpngez1
         QNYg==
X-Forwarded-Encrypted: i=1; AJvYcCWcrfelT2eqwVyvxNSDjCHe3U6nqMcuVyNRfY+k0/xUQCUN+cVhM/KqXPxPhDGuyikKGXCYzapzcA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbEzTWc3dlXy28N1UgGIZIhlqHGM8BekPDiDD8WN8STGTUmYgR
	PuwQowRwh1wLVE/VBGIJVh+ajku9lTQopCKTKgRpQ5uOSkj/StPmwYGm
X-Gm-Gg: AY/fxX6hszCnH0P/iwZbECBZqpRF3wxorAlQEiI56JNbaZmIDV/X4KWdbtFbJa74FNN
	qnTg9x2Y6rJrf9ZCtUzLwccPeG1VWq+0NYz8jiV/FnFFZhMwaZi+5Mm4KROHkafcckSf42rkuRq
	NDDOcUUjkoNwy4dr7LKkQUYwE02lYOCKWPHQRpD0J/naE1bO0xbEvCmv0nrC8ix7baYjdugIcy4
	REQki9WsUDh9ua05SPZtmulJtQ7ZGcgyJEpaQYcNLlZVBpmtmAoNvIvnUGkSo107VNI5e4+3kcR
	GwZR47o1LTYhCvwv6ft9grtFygMJ4DxZatr/r4312uPzwu+DCrXUxn5T7tFz0WQhXz1qKKlwHQC
	gfsVJlynLmjgh7XH/fKQuR10I1zh/sHgKnlz1ADuUq9vnr8kPySjqJYLo+hKAtWN6eF9zgN8uT4
	BIOv2gEOe+Nr++XZ6Oyd18uM4=
X-Google-Smtp-Source: AGHT+IEe3zf1IkKFKkWJiFRWFG2kWewA423+4tt5YeHwRg6lgVblS3TIR8XO7sEvsL2qPIhcXvtY5g==
X-Received: by 2002:a05:6000:25ca:b0:431:5d2:4526 with SMTP id ffacd0b85a97d-4324e4c9df3mr65957051f8f.19.1767612442851;
        Mon, 05 Jan 2026 03:27:22 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:fc71:3122:e892:1c45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4327791d2f3sm69505535f8f.11.2026.01.05.03.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 03:27:21 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: lukasz.luba@arm.com,  rafael@kernel.org,  kuba@kernel.org,
  davem@davemloft.net,  edumazet@google.com,  pabeni@redhat.com,
  horms@kernel.org,  lenb@kernel.org,  pavel@kernel.org,
  kernel-dev@igalia.com,  linux-pm@vger.kernel.org,
  netdev@vger.kernel.org,  sched-ext@lists.linux.dev,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 6.19 4/4] PM: EM: Add dump to get-perf-domains in
 the EM YNL spec
In-Reply-To: <20251225040104.982704-5-changwoo@igalia.com>
Date: Mon, 05 Jan 2026 11:19:16 +0000
Message-ID: <m2bjj8i9xn.fsf@gmail.com>
References: <20251225040104.982704-1-changwoo@igalia.com>
	<20251225040104.982704-5-changwoo@igalia.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Changwoo Min <changwoo@igalia.com> writes:

> Add dump to get-perf-domains, so that a user can fetch either information
> about a specific performance domain with do or information about all
> performance domains with dump. The YNL spec, autogenerated files, and
> the do implementation are updated, and the dump implementation is added.
>
> Suggested-by: Donald Hunter <donald.hunter@gmail.com>
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>  .../netlink/specs/dev-energymodel.yaml        | 12 ++++
>  include/uapi/linux/dev_energymodel.h          |  3 +-
>  kernel/power/em_netlink.c                     | 58 +++++++++++++++++--
>  kernel/power/em_netlink_autogen.c             | 16 ++++-
>  kernel/power/em_netlink_autogen.h             |  2 +
>  5 files changed, 82 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/netlink/specs/dev-energymodel.yaml b/Documentation/netlink/specs/dev-energymodel.yaml
> index af8b8f72f722..1843e68faacf 100644
> --- a/Documentation/netlink/specs/dev-energymodel.yaml
> +++ b/Documentation/netlink/specs/dev-energymodel.yaml
> @@ -47,6 +47,11 @@ attribute-sets:
>      doc: >-
>        Information on all the performance domains.
>      attributes:
> +      -
> +        name: perf-domain-id
> +        type: u32
> +        doc: >-
> +          A unique ID number for each performance domain.
>        -
>          name: perf-domain
>          type: nest
> @@ -136,6 +141,13 @@ operations:
>        attribute-set: perf-domains

I think this can be changed to 'perf-domain' and you could remove
the 'perf-domains' attribute-set.

>        doc: Get the list of information for all performance domains.
>        do:
> +        request:
> +          attributes:
> +            - perf-domain-id
> +        reply:
> +          attributes:
> +            - perf-domain

If you use 'perf-domain' then the reply attributes would be:

  reply:
    attributes: &perf-domain-attrs
      - pad
      - perf-domain-id
      - flags
      - cpus

> +      dump:
>          reply:
>            attributes:
>              - perf-domain

You can then change the dump reply to be:

  dump:
    reply:
      attributes: *perf-domain-attrs

The dump reply for multiple perf domains would then look like this, no
need for the 'perf-domains' wrapper:

[{'perf-domain-id': ...,
  'flags': ...,
  'cpus': [1, 2, 3]},
 {'perf-domain-id': ...,
  'flags': ...,
  'cpus': [1, 2, 3]}]

