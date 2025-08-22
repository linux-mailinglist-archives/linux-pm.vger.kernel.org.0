Return-Path: <linux-pm+bounces-32913-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AD1B31A9A
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 16:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97AFE7BF177
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 14:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1387307AE0;
	Fri, 22 Aug 2025 14:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l39l62zg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEBA303C91
	for <linux-pm@vger.kernel.org>; Fri, 22 Aug 2025 14:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871344; cv=none; b=VUz7TiGBTtP5wPbxWDGn0k3gIvfsYYT7X/uwAvdY01ZjKRjrnqSiV1Jndad0vaWVi5VBlrGXuPwexQQahBqz0IACPKJJcBC5xHaI/eylQMqzjJz3GCwRwyleAVmzA5OWjkBiLTbXulcwxCQ6bBUFSPCtsbMcapohQB8s9jSlCEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871344; c=relaxed/simple;
	bh=gYyhYjRFe/MCyOWzuDZK6z6MpqzEVA9FJJKDcV/4QlY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dfz1wFo2aLF8tACMhkoA65nZkjDzBRT3qpncA+6+yCxxA5tdqBcxosygzCZq01pSkALNWnR1GQ5TRwrbuasqcNQjiphtjeXznSb3pdhUB3sXS+LVQi0tBWoxC1u/iMnQmyUe0RYEPHUrcGTePVcri4ys7zEc2ME3dxs8JiDA6sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l39l62zg; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b4e5c3d0fso4731795e9.2
        for <linux-pm@vger.kernel.org>; Fri, 22 Aug 2025 07:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755871341; x=1756476141; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYyhYjRFe/MCyOWzuDZK6z6MpqzEVA9FJJKDcV/4QlY=;
        b=l39l62zglXF0tLnxydkz0KiLgpgGAn7wz1CbuQMiNgW14z9oZ0s+XzDDTGB4DitIWY
         SUW73wWGFbJR8ggYwlfYfwFAtLJptUtT611t3Q0SneQkumFh9Cjvi+R+5c7ibmD0SAom
         P4H4KvnHiSr7NTCfiL1i87hy99ZZ5GCQRoRyEmTLcHZAmZ8I5Ue8vsbEJcLQzu1YYrXN
         Ft0ZvdHQKR+jKsq80cQDNFLcwCRgc0KcfV3bCJ3v6qMyXWL/VvKdR/RhniotAFCnVS3J
         V6Q+9YVr8v2nvdQ4qrsXag/g0IERU/70LvQ2GcvPNyUkgQUsEmJoGFSuy/m7Ikc4kI7i
         F/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755871341; x=1756476141;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gYyhYjRFe/MCyOWzuDZK6z6MpqzEVA9FJJKDcV/4QlY=;
        b=qx3fjpzERl8u8HV6VOR31WIPMqOyPVbKYx4jZ96B5X57xpmwNiOV3ZSbHPXNTrPSW9
         Q8G9masPDyHbV44OLoBJZQAYQB1YTC30w6W/JY549eW8Y1rs4rToXr39HzZNDBcvxt+R
         3xguI4vwSQeyOIczLg99+mYIWsBJS16BZxnHUCnsMQ3RwwxoOEJEYzY6tOR9N4qJ+GKP
         nxAuBdNczIlXWSf0bUMHjIgRbuhoXSWasKy6XCmECWhxbvazbkQiMz3CNF6+e1dRBpnJ
         2LymoytBG/unO/x6OOueJb4JsvKqrkTjEnFxgG6InxSmcwTjKN9gTYbPbzsQRNXP8oMH
         UxbA==
X-Gm-Message-State: AOJu0Yyo78ty92J7xHYXIISREDeRnpuyrA6Ouj4NMIZZwo08TWDj25MU
	TNuMlAGJ4LaK4VsptCqmq/Ps585lyv/5aB81ccuF1oIxPBY6cxvOeWaQghy3jPz8rCM=
X-Gm-Gg: ASbGncsxY80N9uAEI2WFgndCU9/sVVYGkPRyFbp0/sxhV3GufocaTLZ2KGTkot7/lwY
	aYx78SzKjU1JAcLz0ti9Dr7xk5mNE96KzTD/G6pf44RaM1w5oDZaPCkWDz6KKmYd3/rjRXGNyRd
	sfMDA/FrgzQlG37/JjcRL9AW+0WbnD6qTuDBtA1ATjK7LTAKn7ICm9KUyWAqhEvyZKTHrFg144c
	BmxFWqePgNDv12rCD1NCAAKEDBuTh4rDIUT6ERYhRnkp+RKnnLhyO5Rh9gUP1duq0t7a4/m1bVo
	jmThWeT5Rx22sNUTb7Kmyq5m74cdXGaxpiovUe45XKzf5YUi7GJjnGIdA9c7ig5o1eg53nGgSJd
	d3QxwS8EWLoMMxjk/gVSnu0tUDQ==
X-Google-Smtp-Source: AGHT+IFT6dz01wxDfDjyraWpP9/FYQk97wtO/ycbqzt94+IItcBBAUgTy7bwUGlhSJoxHKv8iS/HhA==
X-Received: by 2002:a05:600c:1548:b0:45b:47e1:f5f9 with SMTP id 5b1f17b1804b1-45b517d8efemr21864525e9.34.1755871340930;
        Fri, 22 Aug 2025 07:02:20 -0700 (PDT)
Received: from [10.245.244.84] ([192.198.151.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c5e024eee4sm3049155f8f.66.2025.08.22.07.02.19
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 07:02:20 -0700 (PDT)
Message-ID: <257d825f0fbe1b9055293513a1b840439f641652.camel@gmail.com>
Subject: Re: [PATCH] intel_idle: add Granite Rapids Xeon support
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Linux PM Mailing List <linux-pm@vger.kernel.org>
Date: Fri, 22 Aug 2025 17:02:17 +0300
In-Reply-To: <20240806160310.3719205-1-artem.bityutskiy@linux.intel.com>
References: <20240806160310.3719205-1-artem.bityutskiy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-06 at 19:03 +0300, Artem Bityutskiy wrote:
> Add Granite Rapids Xeon C-states, which are C1, C1E, C6, and C6P.
>=20
> Comparing to previous Xeon Generations (e.g., Emerald Rapids), C6 request=
s end
> up only in core C6 state, and no package C-state happens (even if all cor=
es are
> in core C6). C6P requests also end up in core C6, but if all cores are id=
le,
> the SoC enters the package C6 state.
>=20
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Just in case someone is curious about C6P, here are a bit more details:

https://github.com/intel/pepc/blob/main/docs/misc-c6p-c6sp.md

Thanks,
Artem.

