Return-Path: <linux-pm+bounces-27127-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DBFAB6618
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 10:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421724634B1
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 08:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB6C220F5A;
	Wed, 14 May 2025 08:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D2BhP+AC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A8921C9EF
	for <linux-pm@vger.kernel.org>; Wed, 14 May 2025 08:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747211678; cv=none; b=fgru/4u3riVBg6PJL4np5llHnPTNVO+n7gVSoMg3PY3ZtH0ePy8RH4yZJblf7MicTGMaqUDpsMDsiWJC44KGJfv60Sgu49ze9XQZuTK8WYPk0sQDX8MV5QKBwPoKzJ82I3+Y8k02vZiuWLcSjt2ZuFh5tOrBgjce6y8vnfmmKgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747211678; c=relaxed/simple;
	bh=DSWauo+U3o9231cQ5RDfCfsPrf+JknAFg22x5w5WXXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOI5QlRpXrP4swxqzQhxIpdB3xVctq7xodrCgKFT24OVlD/Td0NRwyoT/n3rSwIhVCkiQPunWxSdoxs2kR8gYaKFjMaLbTI+rw2zVovA8nMGTO65ScLPZ3UglQA1fw2FN8GEqwdfSHTYN9lcpFB4B/QkKWdOA8qTWnBWYVyiksc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D2BhP+AC; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a0b646eff7so5616889f8f.2
        for <linux-pm@vger.kernel.org>; Wed, 14 May 2025 01:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747211675; x=1747816475; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lpk15JvnYp3a2l2oLG5xWFRwRjCqy1khehzteRsCvek=;
        b=D2BhP+AC1Kl6+Jzut7RbxJR5gbAiSm3QfPVP1nedhbndS+Xveu3Jxlb00lLHsk6tjB
         4UA8ivJC7807dJagm4/FD6SmId+GXLcwqWVAnyv6+4F+RRCr5wziekosOVHMlJTWfpW3
         AYhy951VPeWQcgiLPeOZq2CHhg/f4aN2vhFOlvLYzAyDJrvSYeUQ+OTbVaz1MHgx3PUj
         dkygIhrVMqVVWaCcwUWZZjeNngJNBp0w5gE0yLembeDPyWworRtiHD1nnSf7SKlzbB7G
         /EsBayeKxYpOQklo4COa/izwbVPy0JGNp56WPfc61O+2FMxaOp7L5/hODIWYIre9gKM/
         ybqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747211675; x=1747816475;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lpk15JvnYp3a2l2oLG5xWFRwRjCqy1khehzteRsCvek=;
        b=gyEgTsw81bBPfKsAEcFlAVnIElFfxFwambqykJlQTtg24sOcyRiUkkTmlI2PhNL9CN
         6rv618iOeUi2U5j+xL8hHybS3b+9eO2F89M2hn/BHdvU6GPkypiWus8kfV1sthGCbAjN
         Qrad7hZhlarxqnZwphI5Qwkt0t1jITDABMW/cyV4narLJGqqQko3KHMsjUvLrZFebLvu
         cJtGivCb85f0goArxo9bfsHG+/aacwP+AXCU/YBOuUJ48b4ddzuSwOmuSP+KmJQTdErZ
         sHDSfEizgYwpZXuLJfIXJXI4GtdcpMx+5CJKyax2csO7QRE+M7abwaMv00v6cmGKGKCy
         pkKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTmnx1v3+FPj02td0z1/Jxe+Gg8zQNEP6ML3b+tf3RSt9KsUwgDHqiRUJZDHm/+d5jnH9m3NzAqA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjS093awXfJ/iJSC6HkCRouIkLvXxgXFV8eB17mYtsIYyfzDol
	Om3qR5/YK/njJ83biTJL//Pg3Zz9UAUn5EZedDVaR7svdZTKB31Dn3YyfBkSYFs=
X-Gm-Gg: ASbGncu6RgkCEzLYPxkJObcf1op75oW5nEFwfmAsXVMWUWWdyikXEpNk8OvKExzzpOk
	zPTMCA0IPd6g+r1uyqMPwEDnmzF0nb5t1WpzPyMReXrajI7y45Y7HLz8ZnsFln8NsEc96FPi9iM
	lUtDY/gSRNaUe8cyWU3rS0vYAXqIWgWwQddF+24vG/OT1yZfaGjcjrZKb8dt5iHV6lB0Bi0PndQ
	3VyAe09uaEFXV6Q+BvqeMdeZ6/kNLJfrrZq8gH6heP7N3B/NMMGStYHIyOh2v8R0+dfl3BqJbQj
	qUTsIb1WAXKef7Ur3gfUKFwKbB8xXvwG0qcVCybpa6bQHOr+aGk8a2Tzpzp5PD46Bk+ZPPY00i7
	BNsmCWbwCPMsCSQ==
X-Google-Smtp-Source: AGHT+IF4qjjU+HY8IfZOPpCU5WcWafIwqSU4OR3ehg6IR33UyrDws9inQGF3IDNUyKOx0epG8/Qluw==
X-Received: by 2002:a5d:5889:0:b0:3a0:88e4:3d2f with SMTP id ffacd0b85a97d-3a34968f999mr1902249f8f.5.1747211675277;
        Wed, 14 May 2025 01:34:35 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ecb46sm19060940f8f.30.2025.05.14.01.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 01:34:34 -0700 (PDT)
Date: Wed, 14 May 2025 10:34:32 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Cc: ALOK TIWARI <alok.a.tiwari@oracle.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] thermal: Add support for Airoha EN7581 thermal
 sensor
Message-ID: <aCRVmDk54EX2L20J@mai.linaro.org>
References: <20250510172509.2547273-1-ansuelsmth@gmail.com>
 <20250510172509.2547273-2-ansuelsmth@gmail.com>
 <084240c5-48aa-406a-9bbe-2f349f9c2509@oracle.com>
 <CA+_ehUy+WSzRre+64KxeJKtOb_Et8HO=oMV+fNrGF5HHLzh3MA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+_ehUy+WSzRre+64KxeJKtOb_Et8HO=oMV+fNrGF5HHLzh3MA@mail.gmail.com>

[ ... ]

> 
> Thanks a lot for the spelling check. I can send a follow-up or resend this...
> 
> Don't know what Daniel prefers.

Whatever you want, a patch on top or a v8

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

