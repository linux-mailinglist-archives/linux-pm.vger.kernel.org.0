Return-Path: <linux-pm+bounces-19502-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0749F76AC
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 09:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B53147A77A2
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 08:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DB9217F33;
	Thu, 19 Dec 2024 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lE542baa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE7121772B
	for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734595413; cv=none; b=hlX13DWIWJVAC6f4cuNRE/N1am/fYDdOk3oQioCXsmjf5BH6+n+eKhtLJZ2LAiSSb4+9iGUUJmt8tZuANRYeDX4p68O7R75J2OwHSfHtWIwCRVqYdvRJVEROqzr8xWpD3ggDKxpKDoGAuxECbxyjCCbnF0IBRTe2+PBm/bHdk5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734595413; c=relaxed/simple;
	bh=UJiJoUrfLpwq/NbQZ03B10FmxybeXKUL6QwP8MevoLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4EbUiwfpsv+wjLgErhZ3Gi17V+18vq+ab0XhquDnwSogxcs9jfs5Fr9HyktxDe0It7Oqrzg1ZgvE+9Hk/DhSPPCw0NcNS60xtRTwBeW5Jpt1Z0y1x0FHzv0qQr1c4p9AB0wmwNFl1vHwzedt5TLvEtQBPGcQJei9nCrhcp5LSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lE542baa; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2eec9b3a1bbso343843a91.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 00:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734595411; x=1735200211; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=veA0Huobzzxbz9/R8JSsJ4HAsAbD6I8RRhj1NsnH8C0=;
        b=lE542baa12T/S2XXDakLJuCqo1OIkyH/aW+Elko4R3fIQTQL1mRm8+5vydfUisdgAq
         Tjun5K3B0iUpN/N7GmoUUtqy7c3hwI8bmxmjfpfV4QW1TLiQ43pJE4vrlI7HL2GUj6NP
         fD+h2+o+bgLymYSLpenSc+esAHqtT6laY82+uzUFa9iER2THZS/Ks3I+cpnetKTmezkO
         WsWvI/h44ynCGyoXqJAnFZ+Lf1s5Vzl8AIrGqbuprpFv9JSO/R7YAMyc7mx6MYlPXz33
         bribGg1ANW2d8n3jtJ4tUQyAIl/UCwWyvYv2dEru6UiWboHyso+A7ZqNh9jxaJBaUYtk
         jgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734595411; x=1735200211;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=veA0Huobzzxbz9/R8JSsJ4HAsAbD6I8RRhj1NsnH8C0=;
        b=dqUfLeAXrUzVi7x0Zs4OQnmbf8uvp35ZXPviSxpHJhngOqp+yOXO2iuCNJBFbwOTos
         tXgGR5WtWtJ1vlTlFM1aof+k6IQ3D/c/gFoUXPYUEUuYuwmXMegLXvKax8d+2pT+IamX
         c978o6YZdWw1+TUr3zPAmEw+1fivQXtRu+BXi+wxY3AcG5Lv1uCS3aNn/Fpn7gjj0K1t
         x6mspsPBIzI400V8FSaJChzFyiQwPU3fWMn7m7slpFI4qddPLWb4QHuPjEabi8l/v7cU
         Jlr8IIo/IhKptbOIpteGAWhbKfTMs8O/gmwFUOy9ch2gEuRfKEurA5t6rDJEy6Qdc5oR
         0TSg==
X-Forwarded-Encrypted: i=1; AJvYcCXuG0u82yJcmIAz8RTm95DJ0L0xctE9Yc1fxBA4NIyRIHeQwhRqZfRX/srIgKRJPZDfCwVPf6HHbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSrxlqBoRX7vELG/CTgo0J1f8VRwOJf8rOyaB3XW4pksD7AvUT
	bnnLCk/5qoRn3497KKveis+Nt12a+DfN3QGrAQ08jUeO0BfBSAWOK9YT8qxHRQ==
X-Gm-Gg: ASbGncu6JvubyDYvpfWSCIIO45uiIPQ/+grxyjMnjzMZX+SvVjgP3+5hXXcgTfM8qON
	juJHk0rjU9aMTSOc46srf8K9TMTAcpASUM1wEIHgfsE9gMluZ6GUuMpDdJqMsL8YRhfSQz9IU/3
	/lhBv6QnHDs7ZfbnwspUnUVFkurN1HZgnogJjeohZxVEq5UNmVp+S1rBNqaJyV6Q+uiAhiJignb
	UbpSMqINNVgiWRNCFZWc0c+ouf7l9mbMxqXbcZJUmxOHzPTgIZ9P2JuTXgAsGr5r7Y6
X-Google-Smtp-Source: AGHT+IGkAKRKIGy2PWGUpJtb9ofOGf4tb9aPaoih3oeJ6FkCxuJrXISiTP6H5Og+dCW667T6Nacl4g==
X-Received: by 2002:a17:90b:524a:b0:2ee:d35c:39ab with SMTP id 98e67ed59e1d1-2f443d0189emr2977479a91.22.1734595410812;
        Thu, 19 Dec 2024 00:03:30 -0800 (PST)
Received: from thinkpad ([117.213.97.217])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ed62cde6sm2963410a91.13.2024.12.19.00.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 00:03:30 -0800 (PST)
Date: Thu, 19 Dec 2024 13:33:22 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241219080322.gskydm7mg6srhv3p@thinkpad>
References: <13662231.uLZWGnKmhe@rjwysocki.net>
 <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de>
 <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad>
 <CAJZ5v0gLMx+tBo+MA3AQZ7qP28Z91d04oVBHVeTNcd-QD=kJZg@mail.gmail.com>
 <20241216171108.6ssulem3276rkycb@thinkpad>
 <CAJZ5v0j+4xjSOOy8TYE0pBuqd_GdQa683Qq0GEyJ9WAFad9Z=A@mail.gmail.com>
 <20241216175210.mnc5kp6646sq7vzm@thinkpad>
 <20241219063052.GA20003@lst.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241219063052.GA20003@lst.de>

On Thu, Dec 19, 2024 at 07:30:52AM +0100, Christoph Hellwig wrote:
> On Mon, Dec 16, 2024 at 11:22:10PM +0530, Manivannan Sadhasivam wrote:
> > > So what technically is the problem?
> > > 
> > 
> > NVMe wear out is the problem.
> 
> Btw, it's not just the PE cycles, it's also the sheer time a clean
> shutdown can take (or the time for an unclean enable if we don't wait
> long enough).
> 

I do agree with you!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

