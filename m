Return-Path: <linux-pm+bounces-18022-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 778849D7B07
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 06:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F06C1281FF4
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 05:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C5B161328;
	Mon, 25 Nov 2024 05:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EjjjLmpw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E6B156962
	for <linux-pm@vger.kernel.org>; Mon, 25 Nov 2024 05:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732511710; cv=none; b=caN95gmT5W+UbQLEAjszjRpQxwW+9Jpje6r9ZLr1bPL9O884wU3r52sRhWRV55EleH31pLrrDNzeM1hDGS8Liu1vhjYY1JFYVyDZCdWb+56swEs8hlmCPyuVglO1q6xaGr0cWVJAVdceXqCrxZI0+6CKZvkhgzdcn832wGQh0PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732511710; c=relaxed/simple;
	bh=GZQKvifqnOXtDMiUwvHAbDlHXTsnlY8fC6x4xaJ6hLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAHNJBcEcbW8/vxNgIqJXnQPZfGGzbflIS9jnXTAUNGk6Dzqj7NaywRouuBJLaqOnlQiqcGKdh0MJRupNDNRYGFzhVBE80fPzeZ2h8CckWMmbtnGrdCEm/W0fd2+GFh9D8kOWUEkIwqwN3194tPd9Et0wLGzHb/yY3cMBBKkNzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EjjjLmpw; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71d4182b2cbso468757a34.2
        for <linux-pm@vger.kernel.org>; Sun, 24 Nov 2024 21:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732511707; x=1733116507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXYxVqnEJhk2+ud56x2f1HTA5C+EoDeziNEkUyfUzPw=;
        b=EjjjLmpwHVX5mgA928wq8eKNjtOggoJ6R/aJHJcY33AynKdP5olp3napDUq5Sfoh0S
         +XQ0fNPM7b/NWXjTkibO4c6i7450UWr99Iym1j5XZ3faNhfgQmqKCg2eObT4f52wvh/t
         qinTmi7fpg9BCbx73BEvlZgFVfNHbFOGSiGYxzmY3vCapusuQnCvcMAdyouTLYkLmzTc
         OePq2uR62IG0rDbDL3m8rwKldXXdJXWv1hyja1vebLLDcWwGuQXVLNb60di5nlKUplyI
         zM2pCOENx8gklht+g+BuE7EO1UaReq2fhV7y0LIV/tUbhigdDLTu/9MYtoaJX2Sz/Acu
         QNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732511707; x=1733116507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXYxVqnEJhk2+ud56x2f1HTA5C+EoDeziNEkUyfUzPw=;
        b=kSS4GrUi+Is9nrUrU2Y/Nhmmzo+CUiK7yWdcpVHiR/uyqtHpDpJmcARJU98DUqAFbT
         1Dk76ykS5p+4EntZFE3k2ad0jlEA6SHYZk6lLepqEFz+01r9TTyFphXKH0KPAXYEuN+7
         ZNQuNp6irzM9xN/lqQr/6R+d3PM+WyIPKskB6Xo+U4dn82fpxvgsurhYLXXcPIyeoMtK
         fLqk6rPzZT5PYtYUwRTs/MSW+oYziTUXgG62fQLCuLN0NXN/ff+mummQsPf7ghf3hfKD
         7aQnNNrHTR9JAsrsEAqdSI5Y29PX3A//PXfnLl2aoLY1iVeUinJBpO8TO2SWBmONj4yo
         04iA==
X-Forwarded-Encrypted: i=1; AJvYcCWRRZSKbhlGYDTST0WMXnsrZvKKl2FrIJg6njbfbj0aIBzKK2lqXq98IkhXwLoy0Gg4JjtW25OSYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxIJ/c2rgQcSIYAqTcaNsh5ZfadAtIwEsERCGSBH1srLdU5X71
	h4vpa68RUFkau2iMg4IJvgv/zzpxIvwLExwAiiIg9mO20tbrsQXlKJU1mypHzL0=
X-Gm-Gg: ASbGncvPKRxNX9jKDS8tYstnVwqab9bcSmKoyx8RKliPzmDXt5t3bnap3Z6YQt5a09y
	H7PUMgTRVHiPQyQwYH3zzLIRuKVOkG7iEoZ2nwjznjHZR3zZ2zuMIW2d1Anwez8armVGl3U0n7C
	UGSJjXPGzLrbL2o7qE2sWEuUIdfI5kurzmZXfALUcbkIIwQXhUqgHwMhYDUMQ7CjY0Mf4KxN+Vg
	Z8SKxwLL9JqEn/lxXpztvbYp+qy9HdTSf9jxl4oUulnrJ0HXZcZ
X-Google-Smtp-Source: AGHT+IGBOXcBuIivLmEuv7VtFjk7upyEtRB+SK3bfE8xFdtOYrf7Pj10DGIfwgFhA1L4nmL6RBU41A==
X-Received: by 2002:a05:6830:3787:b0:718:1935:a860 with SMTP id 46e09a7af769-71c04add024mr11264098a34.0.1732511707515;
        Sun, 24 Nov 2024 21:15:07 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc3ddc8bsm5672854a12.60.2024.11.24.21.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 21:15:06 -0800 (PST)
Date: Mon, 25 Nov 2024 10:45:04 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Radu Rendec <rrendec@redhat.com>, robh@kernel.org, arnd@linaro.org,
	linux-kernel@vger.kernel.org, Zhipeng Wang <zhipeng.wang_1@nxp.com>,
	Maxime Ripard <mripard@kernel.org>, javier@dowhile0.org,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	andreas@kemnade.info
Subject: Re: [RFC PATCH] cpufreq: dt-platdev: Fix module autoloading
Message-ID: <20241125051504.nvw4lzr4emi2vpf7@vireshk-i7>
References: <20241119111918.1732531-1-javierm@redhat.com>
 <20241121071127.y66uoamjmroukjck@vireshk-i7>
 <87iksh3r4x.fsf@minerva.mail-host-address-is-not-set>
 <20241121090357.ggd4hc43n56xzo4m@vireshk-i7>
 <87frnl3q63.fsf@minerva.mail-host-address-is-not-set>
 <1c5e13b7472917b5fa303553da04ae16590f3105.camel@redhat.com>
 <87cyin42mb.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cyin42mb.fsf@minerva.mail-host-address-is-not-set>

On 22-11-24, 18:09, Javier Martinez Canillas wrote:
> Agreed with this. Likely (1) is the easiest path and (2) would make the
> driver more aligned with the rest of the kernel (that have a list of OF
> device IDs to autoload / match instead of some custom logic).
> 
> But I guess that (2) would be riskier, since not adding a platform that
> uses v2 will cause a regression.

I am inclined to go with (1) here and have applied a patch from Andreas Kemnade,
which he sent sometime back. I have used your commit log though, since it was
more descriptive.

-- 
viresh

