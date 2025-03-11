Return-Path: <linux-pm+bounces-23846-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1FAA5C41C
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 15:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8F557A143E
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 14:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1716D25D8E1;
	Tue, 11 Mar 2025 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ebsx0eSt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D5C25D20B
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741704086; cv=none; b=Kh+hsnA01JeW91hTHl+0JZVclEvOKVW+1JzsQZT50Q1MqlXjaLNdNQj27HR2apNXwEnwieDNnA3iVTRkoW13oxnO3C1WmWDvfrQQq/U4OMPB0h3TGeyAwea51FcX0CR5hzZz8UsaKAy3bTumD2mQpHbVQUialQaOE54dSSDilXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741704086; c=relaxed/simple;
	bh=e17YIKewOJw7kg96MYs2+UoD1X4UIFS2MZO7LIlijb0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QwfzV3Crx3H+pPxwJnagBHnJI2o/w1iXA3HHo2RDd49TWPIAgfuYf0aM/d48G2tjLRxaQ9N93LvwAARt7lBdX3NGuTfJQ3JTIcHvoy6Kip3dAFQ1SW061qI9D9F+GLyo/zFadmuORDD0wv3Q5V/DG/9gmPV1skqFsv/GzUV2ijE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ebsx0eSt; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39104c1cbbdso2757540f8f.3
        for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 07:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741704082; x=1742308882; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e17YIKewOJw7kg96MYs2+UoD1X4UIFS2MZO7LIlijb0=;
        b=ebsx0eStJiZ5pRpBn1LGcNEhc9/ufzisag743zx7HByV9d6QSHMUqiwjqKgjpXT7oL
         2vU8+xXY9ImNkzAqhc+EvhfqYqXs/uWL2Taa6GmFvD3NYqbxPKKX1EoOzb1udEsEZeIV
         YJMzBGzfn2T/V8bTe6+UFGBu37NvTG5FEH+jse8qcaaAHoyMpnUgjuYM2e4fIXJ49Tif
         Ri8NcB5Eh5UfFSrSmJvTQbmlPNGjjZKPN9/+jzoXRz+g6N4StRy0oD6tgbLofE5XvswW
         GqO8Q6qMMwJur3txS14MNAJbQbBRMFnv8s11YyW0GvnX0T4BWus+07cA2MnUkpj/u27U
         sK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741704082; x=1742308882;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e17YIKewOJw7kg96MYs2+UoD1X4UIFS2MZO7LIlijb0=;
        b=ZTZgsUvrSFbP+3j8I1kZ7t2Am+uDjeUxkn5qjUQ7kTcKjue7IO76svdkAjBVO6I123
         2cFVEEhYoBSFoLcRlSOhVOxd//tZfLNNifZ7ajs3O72cAqR/HTD9k29AjINTOVcI2Gro
         QB6FV4luyPGy7baYX3/xD4T693r6CMRV6yzYlraQm0wS4sfHaPFXdTz/8Lqy+igVRPMh
         Xj8ArbyeSPi8EjfkEkFRJ5RsfTXp+B7myMRFzdM9PnHsI5zIC4axtwCSuw8rTO/qzMmL
         y8m63DROz+HRyVYs1Qsd7rBJuEYqOUNCY16tJE7bUdYwBdNS69k/+zxT36YzNaMInWrm
         GwoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNEjCM9+scVLgmaqtBO87sxUIk9M3SlNONdoJe/0Ff+2dPeYv40CVqjnSDtttZ+kE9umdAJ4fJng==@vger.kernel.org
X-Gm-Message-State: AOJu0Yydk9M8l/GxT+FsoPS19rpIjOdv7JDmvccCgfReBkP3WGaSeu7J
	qznYNCjwfAlBQfuZk/St9vkAeuNSfcrwHD0JWSMrWeCmHGI4PuR2kvtKDYN0ebU=
X-Gm-Gg: ASbGnctL2ClbhvadPj7MV3Hld4tXI6LfIbga5GKMBGgfMHKM/dnTlRY+dUFmZrruL/j
	T0UwSHL623CIUjsOyEt61oc4YPIYSBxBpl+Ot3GYCwepk09OrIbH+YUMeBVItHJfKZ1g/wcDJVd
	6+HrS5v1YROAH8yWCYcXqDOgb03JcXuXV+7FuISz5T4RGgb6yWx3MCIj9ukjEnaWIfeceJZCm/u
	Q0GWt3MahIxfYiVZIhblR/EiHdAZE0D9OsBdXBCbvaUXBUmtvp7IeWTtMKDe96TYvxVwr0SSoBL
	WorQL4qQmLf89m8Wb+eBmNmS4nV0jSMuu9TKPd5/TsBx1Iu11ncfMEOE6PS+Fry4el47aIvKDq4
	=
X-Google-Smtp-Source: AGHT+IHedVj4RUj6sW41ewt21ZWFTQVrQn0/iCeA7D/35qQUSXCzs/EtRBqy+mOCc1u29u+Bx4/luQ==
X-Received: by 2002:a5d:584b:0:b0:391:4873:7940 with SMTP id ffacd0b85a97d-3926c78f6b5mr4736641f8f.54.1741704082203;
        Tue, 11 Mar 2025 07:41:22 -0700 (PDT)
Received: from [192.168.3.33] (110.39.160.45.gramnet.com.br. [45.160.39.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0195casm18675615f8f.53.2025.03.11.07.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 07:41:21 -0700 (PDT)
Message-ID: <9a8b7634b123e82c3eaf278a5944feafd91279cc.camel@suse.com>
Subject: Re: [PATCH 0/5] printk: renaming some suspend/resume functions and
 one fix for unblanking
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Eric Biederman	
 <ebiederm@xmission.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	 <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Steven Rostedt	
 <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Todd E Brandt
 <todd.e.brandt@linux.intel.com>, Jiri Slaby	 <jirislaby@kernel.org>,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-serial@vger.kernel.org
Date: Tue, 11 Mar 2025 11:41:14 -0300
In-Reply-To: <Z9AvKmM4Li57-E2E@pathway.suse.cz>
References: <20250226-printk-renaming-v1-0-0b878577f2e6@suse.com>
	 <Z9AShs1dEO0jrgjL@pathway.suse.cz> <Z9AvKmM4Li57-E2E@pathway.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-03-11 at 13:40 +0100, Petr Mladek wrote:
> On Tue 2025-03-11 11:38:00, Petr Mladek wrote:
> > On Wed 2025-02-26 16:59:00, Marcos Paulo de Souza wrote:
> > > Hello, I've being working on some patches that help to clarify
> > > the suspend/resume
> > > of printk machinery. The last patch on this patchset address one
> > > issue regarding
> > > suspended consoles and blanking.
> > >=20
> > > This is a part one patchset that I would like to see merged
> > > before I send more patches
> > > that will rework the suspend flag (a global suspend flag istead
> > > of per console) and
> > > the removal of CON_ENABLED flag later on (I've created a function
> > > that will forcibly)
> > > register the console instead of using this flag.
> > >=20
> > > Please review!
> > >=20
> > > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> >=20
> > Looks good to me. I could fix the typos when pushing.
> >=20
> > Well, there is one more thing. It seems that the simple graphic
> > logger
> > was merged for 6.14-rc1. And the console_stop()/console_start() API
> > is used also in drivers/gpu/drm/clients/drm_log.c.
> >=20
> > It is actually the code which motivated this rename, as already
> > pointed out by John, see
> > https://lore.kernel.org/lkml/ZyoNZfLT6tlVAWjO@pathway.suse.cz/
> >=20
> > Well, I am going to update these two locations when pushing this
> > as well. Let's just get this change done.
>=20
> And I did as mentioned above.
>=20
> JFYI, the patcheset has been committed into printk/linux.git,
> branch for-6.15-console-suspend-api-cleanup.

Thanks to all reviewers and to you Petr for taking the patches and
adjusting the typos!

>=20
> Best Regards,
> Petr


