Return-Path: <linux-pm+bounces-15410-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50607997114
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 18:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12EA1F2649C
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 16:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4C71E885F;
	Wed,  9 Oct 2024 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XbfljYFi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE4219CC3E
	for <linux-pm@vger.kernel.org>; Wed,  9 Oct 2024 16:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489972; cv=none; b=Jiqx9dqDZJ6BDwNe1He+o223LEoKxaEWVCD6+/6NTbZFHPaTeRU+BuM1QrkHGQ0ipYaUSgtiooqNBiKl81f3aQEQpLmQ3QWCFffovDR6Fjz0EZaBfVe+gFrTSq5+0nZxkHOi6zG34hmZ99PRjMuVy46xR8hdqAohXhi/zCO2aNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489972; c=relaxed/simple;
	bh=3Vge/iwKjCWd2R94XXdwXx8iYmEQKEaMiC60ptPZws4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBitWW3OhB+hqeayalqBZTeMo7J7dEanZhTzHzfEQC+r2eTqi2WGDN+vGbfRqJFIVmkDJZL5aZLLG4XXZhyNXFUSZvku9TVKog2BMbIs1XJGe2u1os8G42ybZoKSndxkRSVOZ9AYMtksnD/4MjiZ6xGvsjx1Ll/O0APTB02F8LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XbfljYFi; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6dde476d3dfso120817b3.3
        for <linux-pm@vger.kernel.org>; Wed, 09 Oct 2024 09:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728489969; x=1729094769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Vge/iwKjCWd2R94XXdwXx8iYmEQKEaMiC60ptPZws4=;
        b=XbfljYFiQVe6g4GlQOWOizSRi+/piasdMGDpUPjWcgwjVxqQ2reHMwBPZqQ0PsJoD9
         erRP/jco0xVCOuNbBAiX2/B8Zh4ujiibgkirTLRp1sCEvvSrfDwrIyMDqh+IAfgG/KGW
         S92QVV15VBxLdK48Vji40pGbXpsNK6zqmuwStb04Hk4EbQ2CG7YVndUZ4Qy53MKdmsWC
         Bcn3Jnq0++2Yo9FV74Jw46f1hsebv27L0czLuFh9fG6JxV9eMAodyj7X+iKEzhv35stE
         aONa+Pv1wtmHaJMYBkSfGbENlJ7cvVVAubSLYiEyIW7b/7O1NmyO7SWJ9Ci2ncAljtHs
         HWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728489969; x=1729094769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Vge/iwKjCWd2R94XXdwXx8iYmEQKEaMiC60ptPZws4=;
        b=KWIjdy1uotbAIacj+tl9At3E0ck1I/9Mhj6lzOVzdp/oQt/I0rNWfpVJprX4/AqV+d
         ALnLZJGrnNx8CPowJheyrQ6GnU76zwVJElptyHtAwHmr8EcO8rFaDWGP2duCk7sO/e6r
         tZ9o4Xcd+AXd0QfwUqXBdRjfpuMUWYBSEaL2LxIBFioVtU/kqUJ1rHsL0d5V5jxraWoe
         vZ5YVXYbfoAhEW2VNPETzl8oiF88iTw0J0v4B52XXbTmT6JZDmhMJxcHSyjLf+fhj+31
         fhHnWMViVXMEUHdIaa0+neTx8aLO/t9eRBHW/AjTPLo8RVbf+JpajivnrDOy/9QIN7HV
         X2/w==
X-Forwarded-Encrypted: i=1; AJvYcCUwi8CoozNUkEtW+2phTBOFLNGLjaS2MNDe+NcKG76ePGeyUta5Zjb1CPPVW08noPl4+wWgbu9Upg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yytv3gh7MYN1udrnYpoBlejRluATneMjuO1PfRU+0MqvfY4PcUZ
	f1aP7y8y7wz1C0CFoEwg+HGxtssdUfvi7yKkCty12TJOTRFKCAKmGnzwKhAneS3fTcyZAi8BfSs
	hggK2nDphJYHnkRUM8RVE9Dn1EmTZDaAw/o2mExguaSFagpBU
X-Google-Smtp-Source: AGHT+IFcyreBzw5VlY3rdfyr3fwEFI+o5pWeKAPwPH/IpwyWII2FcOYUF3isT1hLnHPhuyqMZAnzxrDwH/EoiLrn3Os=
X-Received: by 2002:a05:690c:dc4:b0:6e2:1467:17b4 with SMTP id
 00721157ae682-6e3221317edmr33059717b3.9.1728489969296; Wed, 09 Oct 2024
 09:06:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005-power-supply-battery-const-v1-0-c1f721927048@weissschuh.net>
 <20241005-power-supply-battery-const-v1-1-c1f721927048@weissschuh.net>
In-Reply-To: <20241005-power-supply-battery-const-v1-1-c1f721927048@weissschuh.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 9 Oct 2024 18:05:56 +0200
Message-ID: <CACRpkdape9jmyw7dXBkzxcrMx5oFk0e=nBBbRW9QncDJptZ7UA@mail.gmail.com>
Subject: Re: [PATCH 1/7] power: supply: core: constify power_supply_battery_info::resist_table
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Sebastian Reichel <sre@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 12:04=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:

> The power supply core never modifies the resist table.
> Reflect this in the API, so drivers can mark their static tables as
> const.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

The series:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

