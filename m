Return-Path: <linux-pm+bounces-10744-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14DA929C5C
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 08:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DC621C212F7
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 06:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6858013ACC;
	Mon,  8 Jul 2024 06:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j6XsnBZQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F060E1171D
	for <linux-pm@vger.kernel.org>; Mon,  8 Jul 2024 06:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720420977; cv=none; b=rjN2q6jcG3YrpfOFvHrT1yru0WDPY1ROZ9kXpkypUobibmAPB9EwjrIWuj3LTNQvgi1lQvrp7yyFhONoogeBvgwz5qg31Z+9ULUCnW429qCl/eZs8AkwUmcXw9DlIQ5sjzuvULTjYsrxfvlsMgJzE8sXwGI9RW95aswGWfzxu/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720420977; c=relaxed/simple;
	bh=XDCXukSSG5eu7Enir6B20Xw7BTHGqHHg5Qjp0HFF7D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzhWtyHtwMb5kmdvlBplCjkK7m9kicJ+HXt133K2MLQ6ZvKayAVZQ35fVPsXSr1O/wTU+hkG5NrEbR0nEA7YssYQksfI7V3Q3ONIVfN6EzobFWUkRtPwrPxMPUA26M1gmnfzCivXVXIj+7M9e7iM+HxkrYcCs813raIf4xTRzaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j6XsnBZQ; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5c477d97159so1825037eaf.3
        for <linux-pm@vger.kernel.org>; Sun, 07 Jul 2024 23:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720420975; x=1721025775; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1FcWtX9vaZBCwduln3dpe45i1fpCK57rnuMSwlu6aWA=;
        b=j6XsnBZQ+KLh0p6v2x9lK//D99xqJ2pfrdVgZvmSuyl8Ep17Ci66hOgGaD2tt+Cb4Z
         h1wW8r+7qEXsI2LkIrvoCEy4PF+IG/efjJe6xAaWcdVfH76bjDsWp5ebdbj/4klDai5y
         5CkZU2vVuPZJTbda6ttRb3xM7/QAPjRStFHY2RCZ/ZaDqX7kRsy8mzYxNaquflqaklET
         VH9dL6E2hjBfx5xMKngMeXF4TfO4rRgMlQGa8qAdZOhI50IjJGmQ9rtJ0d1g7pdRmoJJ
         sjdascT11jiNSFTXsWap467yXHVHJ4UimXgri637BIDEZOK+VXuw1wOvmN2rHXw680oR
         o6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720420975; x=1721025775;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1FcWtX9vaZBCwduln3dpe45i1fpCK57rnuMSwlu6aWA=;
        b=cf5EMtXfuMALrTyjKTtHVH36BIa4+4HxTHeWPznUC7fZY2f6NEweC6dF8aoXTEU3zz
         U0+sj5FGq58MdcluNvf1WjYkhpjDE1JsjPyD4qjnfd0uGe/vVpDP3XZuvDQK5A5iVpWC
         CWqHFPy6P38HGki/vZR+POx+DTWGIvW4cTq5RU+J0nc1E2fi2+NErdGisETSb1pMjg/E
         n2hJKwD+Nf8AOubEo+hVzRMFB9A2b5by12ZyxHzIa2Gp4CbfazlmetCcv6ew7hT8U9we
         wnDio2hNnGm5sAm/JMLNB2/yLIBORdoANiZkSpNGIAPWX5wK1h7jdaUwHbbPrBU9KLMk
         CEHw==
X-Forwarded-Encrypted: i=1; AJvYcCX4rF07Jc0uC/qLnhzkfCg23dMvmgTtZ39ryXKCQZCswyqKbVaYqCI9AbQyHLN3+S08dXGhvyGhNxv/OvxRwVT1a5L1XdjER9s=
X-Gm-Message-State: AOJu0YyEM+C7gUV7VXdXDxqBd8LyA0g8EsPKQbDW02sNKMYb9v8WYPvx
	I0YTPv5uX8f/YLvHKNvQT6mkkGMVAUOnz1sI9Ky58rCbnVXvo3WAYsrfDcGHY4A=
X-Google-Smtp-Source: AGHT+IEpqAis6dJIEMNcexBdNxU9+uzyMP+q55/0m9GwePwrj4Gs0P9PuuQDc9r/zZs34DMwLSdBrg==
X-Received: by 2002:a05:6871:688:b0:25e:14f0:62c3 with SMTP id 586e51a60fabf-25e2bd878b7mr9528568fac.33.1720420974988;
        Sun, 07 Jul 2024 23:42:54 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b116e43f0sm5260455b3a.101.2024.07.07.23.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 23:42:54 -0700 (PDT)
Date: Mon, 8 Jul 2024 12:12:52 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] cpufreq: mediatek: Use dev_err_probe in every error path
 in probe
Message-ID: <20240708064252.sydvhfnmx3akafql@vireshk-i7>
References: <20240628-mtk-cpufreq-dvfs-fail-init-err-v1-1-19c55db23011@collabora.com>
 <20240702055703.obendyy2ykbbutrz@vireshk-i7>
 <aa6e93bd-aba2-4e4d-bce9-04e818ac25ed@collabora.com>
 <20240702084307.wwvl5dchxa4frif3@vireshk-i7>
 <8602bf12-1b8d-4249-8814-52ecaa29d0ec@notapiano>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8602bf12-1b8d-4249-8814-52ecaa29d0ec@notapiano>

On 05-07-24, 11:13, Nícolas F. R. A. Prado wrote:
> That would only run once during boot and only in the error path...
> I'm confident in saying this won't amount to any real performance gain. So the
> usage of dev_err_probe() everywhere for log and source code standardization is
> well worth it.

Hmm. Fair enough.

-- 
viresh

