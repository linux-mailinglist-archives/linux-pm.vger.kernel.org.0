Return-Path: <linux-pm+bounces-35793-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C365BC2AFB
	for <lists+linux-pm@lfdr.de>; Tue, 07 Oct 2025 22:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 724BE188C08A
	for <lists+linux-pm@lfdr.de>; Tue,  7 Oct 2025 20:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E867722D7B0;
	Tue,  7 Oct 2025 20:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pUSJO31+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405A7170A11
	for <linux-pm@vger.kernel.org>; Tue,  7 Oct 2025 20:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759869985; cv=none; b=XZWIBw2Mj40vl1ndCoIK5iOqzHD/dAJR6NDhQ1FdAKcwbJ5RoF/hfWkqxI9cYuJkRJgclrZhp9Bj/DH2yTjftXx2A9Y3+EhBPFvSbFcmLSAyQ+DnTxTTHUobmu1VpP3Ddy4tsv8NDCo6BrQEAMUGIrT+TAOFDn6OATrowXtNP0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759869985; c=relaxed/simple;
	bh=LbdMXV3ozTZmE/S9AboaOaM8iqRjDNxZDvdwE/Es4Cs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/nhu7wmPHkPODl6KDIwl8wNcx4+78T+JmI5WH1OcwDx59DJn7ZTgsoc0AEczeKT3LOfqSjXSVwnSHZWv9P9LsX3IgtbKfrjlfK2LHwEyn8DBe2kQvPVhbPumSvTY7BFXw6rCCJ9ZLYzX/y/H0ehaoA6iI7poZMfmKJGAtavZZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pUSJO31+; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7a9c15464f7so2134057a34.2
        for <linux-pm@vger.kernel.org>; Tue, 07 Oct 2025 13:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759869983; x=1760474783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbdMXV3ozTZmE/S9AboaOaM8iqRjDNxZDvdwE/Es4Cs=;
        b=pUSJO31+QZeiKVVhaGISvowrx0WkWAOveOLBZf2c9BTC1f4qjkIDLfCyoOnxZ/GdgR
         d85Ln+ToATRTkEyEQQ3/nl/MFf1xK7fXIIJggUBYgQjZTtxlFYwYHKPEJg0HNAbqMHWW
         Fd8J3+YQLo3doOOyx7NK6lOTrlRibz0vQm3jHg4g3cRL6Qeqf497GYo1eXWBlerfk3gO
         2TEhuZiHCiuTYSXYLZzSIPLHxaLMNmbo/xp+Mn0HnadDsYR6JfInomB4EwRUipwCWABL
         joW6AeWpugEWwHxq+fQ3FBr7XhDpdRCnXAKBrrROJxAbQYzf1KfGWRTKiaSB/blCYBUJ
         U9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759869983; x=1760474783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LbdMXV3ozTZmE/S9AboaOaM8iqRjDNxZDvdwE/Es4Cs=;
        b=Xzu1IgsfzCcPVtE9yeEVA7ItfT4RK8oaPpOJxS0A/byDidFpQfe/7X5LO/iU3FBFRl
         CpQWcvdjvpaMSB3ib6ArQEOPf/1khWv/c25vdk3DHCbIh0ZhmJa5T3dVs0O2tsjP91b/
         4rvAdmb+MUucqsTO37SQWYWnRU/jmdklNyZCnnWuj5wc46uDK1f9L92xI4A5uryP6Ol5
         rHBK3vKPmQtrurvUPrHaNSNnWlAht29mLTnbbA9KVc4ZIDoH5mRQDg/ydKmCI7hqQ9qz
         C8jfOtaL+FvtASI1CprAmaUIqYVmNwtqmyypcYTjJ/iA1KcAIRsfrzOaVryo3MlVMeXc
         itkw==
X-Forwarded-Encrypted: i=1; AJvYcCXQttJtgisycg8kXriWYUeQqcQyJKUalFShb1BqQTpXlmjX/c5p7EsleuqnvBoIZaRKY30DXUzkHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVzv5WEZ0/7EbkfsBXmYQfJ8vVrWrEGC/C7/7CMgT0J6vcFRDm
	LDxG5Y4owFuaHPrZcLEHWjIlkB8C18NNML7TFRJBG22AST5u56JEyapxyd8goo1n+bLaHdycneY
	kVh4o8hlwgJzAFjOfbQ0rYuXYDQsFmLndV2LMFlFk1w==
X-Gm-Gg: ASbGnctU5ln4XDB1I6qcAw1Iqz+zpMVBDPymDI4jjQ1bc+X7JiumAwimh74ybqKdzzI
	9uaC5AqkT2jNRocamEOUPABuwUr0hkCjJS9VUoDZOee2/yxzkznmrIdcj2SrsHoAoKHi6BvQRTS
	9BdHPUOXnSd5o+guBy+LBwjKrtXSerOVknyKxstk+1VB0D1V4urnjHki0ENnKmGRADQyFkJAeVp
	ri+YvA2Q845pHMxNqeLVIWv9NYKH0/masX8Ig==
X-Google-Smtp-Source: AGHT+IGcTMLJLJFMRFfxr35P1VFknbDk8xxpM6Ma7bfAlp8Jh6N302g2i+0XPxTMnwxgopW6JsJbBg7g+qmgQgVNk1I=
X-Received: by 2002:a05:6830:621c:b0:746:dbc7:e3ee with SMTP id
 46e09a7af769-7c0df715858mr633841a34.4.1759869983308; Tue, 07 Oct 2025
 13:46:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-gs101-pd-v1-0-f0cb0c01ea7b@linaro.org> <20251006-gs101-pd-v1-1-f0cb0c01ea7b@linaro.org>
In-Reply-To: <20251006-gs101-pd-v1-1-f0cb0c01ea7b@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 7 Oct 2025 21:46:12 +0100
X-Gm-Features: AS18NWDxc12ZxAU4LNjeEPKBB8NsjHFZacb56hFZBSRRIbtDZk4xL2W2KL2JXWI
Message-ID: <CADrjBPrT6LVqs2NSu6HMWiQ5Rm59pXcbfcjLc3ZxrVBrMjGQwA@mail.gmail.com>
Subject: Re: [PATCH 01/10] dt-bindings: power: samsung: add google,gs101-pd
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Oct 2025 at 17:43, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> Add support for the Google gs101 version of the Exynos power domains. A
> new compatible is needed because register fields have changed.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

