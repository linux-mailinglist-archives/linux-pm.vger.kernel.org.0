Return-Path: <linux-pm+bounces-35900-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 450D2BCC7FB
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 12:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38D794E62F1
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 10:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D15E26A0F8;
	Fri, 10 Oct 2025 10:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SVFzGOsq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE3026CE1A
	for <linux-pm@vger.kernel.org>; Fri, 10 Oct 2025 10:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760091413; cv=none; b=rT22P9Y61L/fUNc3DRCZhN66SLkiAnzNN5hG1UIqANO5IH4LL0rGROLls/g+EIGtHvSO99eWPwYUSGaO6yALlF9FBSV0fMFMdV+Ym/M5BMgtXFRqTbpihIFcf/oz4b0AUEip7O1lKLq2MZTrU7d1soZDrDy+NKdyeYQuigFw5cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760091413; c=relaxed/simple;
	bh=TdmJ+2kI8+/RDkbpkVdAstKtFYS//nGmanP6zPsFxk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lr797ijvUICYooSeLKsqAUw9laaj8IYVCiNSsMmK+JbQ6lyHf62MWbxSqiTYa6mZFAuRyTpAgiSS8UXzQ0tqPNhuS+5AdvMuY8h6RPv4+2JxPAnVVzH9v4AMN6hfYWnE3vwU5EAknFhmytoZT7hkdmDKOIyC2vCDILKEzveTp7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SVFzGOsq; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-375ff2b3ba4so19808581fa.0
        for <linux-pm@vger.kernel.org>; Fri, 10 Oct 2025 03:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760091409; x=1760696209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RZH9pVVic2yrv+vJewn6WEN5CmY70TqVTWa15Zi6Jo=;
        b=SVFzGOsqlOI2TffWAHG8p6wQYtle47eB7QMDw/HfRV3Ms23k4GQmFX3gAvXoskLJ1Z
         0XaotkA9/R6CqBOtzH/EDlLlyNGnmAJM4zJs4IY0wThQ9n50BbDcf4s/qOTcRQgh5Ya4
         gfiIADvarStSIG/eXGbSznJwKVJkuzQUK+lYMrCYpJAPljwzGYCQdqdswTenInH2zvT2
         UiKzTPO5G/5Vve2AaqhfO4+/c48hf9KlWC5ZCp6TWQtgaLRmt2xv778HRn36/igX3qa5
         edwiyUee9u34sv225Mt6PJzw5ZmksF737TExPqu/UJJLI8XhRXKGnU1MIiff5iY+49Kc
         kcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760091409; x=1760696209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6RZH9pVVic2yrv+vJewn6WEN5CmY70TqVTWa15Zi6Jo=;
        b=VceI4j8iU747lAL1PZroXdXS4WVj5fSuBct2wq1rOQxeDOgvFFv3ztsmUXDhJDAty6
         Z+4q7nmuX3ARkyrrj0+35ikVTHLv5DYPp4iA+FLnheyPGQwQvVH+W9Lwb2wasIRUXLcO
         CKYVrR30JjgTzg77VCvyjj3QI9SnFh94hQtJbu76lzlyBl6ALd/mBxFsDTUtATBSLgr5
         vT/zgh26dIBLuUtXDr/k6j5us0h3QC325HCP5+sKDumT7yPtVk/nxeioAGTX4kveMizO
         95XGsdomrGVUB4Y7z48S91d7sPx2vm5TbC0NqEc1bEnRNGvVlLQ0dGcddMtLq20nuTn5
         xiSg==
X-Forwarded-Encrypted: i=1; AJvYcCWITcOR8919iKQIN/YMs5t5GyTUGm6xUf81tlJXojySReAr4ItLM7DeWWD86lECM9VZzpOIWssb/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyreX9n36O/XNF5oTQM4yaMzyLYy4AmaTVY4gQQz0N6rOKB+h/0
	oewkfN9OdqICbIwIwSiNsSwX7ZEFCXtDOIxPCybGGtoHqEh+/81Z2zXZH5VPGxnQJtgW5MASutH
	5rE9bCqi4+QpUlWAh9tHoBEuk/MqtupzWwcS9k9HpMA==
X-Gm-Gg: ASbGncujqsypTdHL0UTaZC3TmlMmolk5KOUajCnf5lIO6hb1HdbvR5HXO9fEstn5iXi
	/y0cr8JOz/rbMpoWVqlOnDgPJBJTULui0RMyBcQgBsMjA2rJQnaN8hGwGP8hHB/QBJwzx9BfZw9
	370r4wtJGs17FhSt31kjGrJHQbVfHP1y9tykFh9vSrQO71Bqy4IEsrzAC0hRBaIxmOBbhFG8NVL
	SbaoyNXJcORlI2mk7SJMqRo2+b7HdrpTE0SIudVJTXGZC7f3+au7lP1gzo=
X-Google-Smtp-Source: AGHT+IEXRvJ8XhmXj2vuM2dNk1/SZz201oiVWS3ljN20y3owcyTmbgsfzpPD7YEtTSRm4xRpV3qILIAV4rfaovTTwgE=
X-Received: by 2002:a05:651c:198f:b0:36f:13c8:d8b1 with SMTP id
 38308e7fff4ca-37609cf7e11mr28806811fa.1.1760091408953; Fri, 10 Oct 2025
 03:16:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919153008.324338-1-marco.crivellari@suse.com>
In-Reply-To: <20250919153008.324338-1-marco.crivellari@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 10 Oct 2025 12:16:38 +0200
X-Gm-Features: AS18NWAlKW3rJg0jncQpstAVBsGSGT6yTYbs_WIXlaZOyA4r94AD4HhFVgeaTI0
Message-ID: <CAAofZF7datQsN0xJXXJs-t33vh09D5+=2F67Q+GL=TSsqCb_zw@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] PM: WQ_UNBOUND added to pm_wq
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 5:30=E2=80=AFPM Marco Crivellari
<marco.crivellari@suse.com> wrote:
> [...]
> Changes in v2:
> - WQ_PERCPU removed from pm_wq.
>
> - WQ_UNBOUND has been added to pm_wq to make explicit this wq is unbound.
>
>
> Marco Crivellari (1):
>   PM: WQ_UNBOUND added to pm_wq workqueue
>
>  kernel/power/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Gentle Ping. :-)

Thanks!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

