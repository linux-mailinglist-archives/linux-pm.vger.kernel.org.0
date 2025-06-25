Return-Path: <linux-pm+bounces-29522-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D4AAE87F0
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 17:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 246486A0BB9
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 15:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105052BD03F;
	Wed, 25 Jun 2025 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uxah5N//"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701BF26B09A
	for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750864983; cv=none; b=PcFLbvWzRurhmuRLLzRaSdr2P1jp/2Pr9no01cBm6RYl2hiayTUSbCXJEz0UY317Ym3HuyW+NVubS8wzpbvN81cuIO/i8oVkNwHTViKmxhb8MolzgqkMDOulB4q1NBKyLsg0DXFxhlbpugohGSg1N5bxshtKzdBdMcLyLWPu7Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750864983; c=relaxed/simple;
	bh=iBrRIymMsNVLfP1Vr2TSs53V9TcNOwALPHl8fdKpW1k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QA8F5EdYLSwcfD/1bCHwZ6k+WtetNJsFRdZmRqZoDb+2NcApQ9ro6JprHQ87RXV36nOWyn+9nRUoQFsnlSkG0PMwsAS3uI03YcoPMNtkLPl8uTydSygW0UKCfago5pw2Bnx0JY405z5DNznQyrLUoHvkG4YpZLhRheNml6F7nb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Uxah5N//; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-40791b6969bso27162b6e.3
        for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 08:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750864981; x=1751469781; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vOmHUd/NAEawgaUPAomVCwxOIkJW88w+gcemZQ4Lc9o=;
        b=Uxah5N//UKdQJJxMAwjCdzPSkZzRa7oZwXjDtfjkBdpgA6QlGgm3+4ekh232EU2yV4
         6gBRb3iSc0V1MkyHqV3UtULrc5HnghdCehgStoR12ZWhlCV2ACRUYH61nEKzUPTow7Cc
         xAIbRdN4QOnwNyfHEOjJOG/7rI6ER4h+Ao/S/ouUfn6LLmGZZVwYFW/NZMGb6KAmfVUK
         VHTL7n+Jd7kPuWa3rdw+YSzfy/243MlX7lBm6MXZp1j1I6MxWwwtvyMGJgeLTA1T6jEe
         ycrw1GWqtZjdjCEfgaIU7i9b1CxmOAGRxJvoKSraGqN/7deg3+gEA6G8okOJdL9v0pvW
         XaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750864981; x=1751469781;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vOmHUd/NAEawgaUPAomVCwxOIkJW88w+gcemZQ4Lc9o=;
        b=L+lFgMMlR01Y97DONCkMeGQhvgCjpfk8hp7BN7dBIiPagyT/YYADNfeQjClZSUUEja
         nJU6DTgGl/4hzUCU2ydtsnPbyFtVcGRye/gYalThlKU4UhIzZm4Pk6Hex/EAz08uDQkh
         UibwtFgxX0WVN770EbvgmjsX/nWiMi+U1+k+gR5Euxm+D1PYYrgmg6WOus+4ztW4rbhn
         90nmalYQKqX/Ll8aIjuPzbPCI6JRH5c128+sJyaOR0blQ/FSluaZk8fyr+FozkPxxlyd
         uPvOmjsnpk39ZeWfpIVGPBzfR3f3nbKJw5VIf36bteOoDYUDpKdsuwdJYeYlg2OiqduV
         /amw==
X-Gm-Message-State: AOJu0YyEbqq9JGW4M/pTJXXbtaWRij/ctxbLUkk5OU47IzqP6bp/bbJJ
	z1Xj7vOuufhmLTAghpU3JFlOukbtJATMNi4/ZMVK3clQqwvONMyaxGN9WLYBN+iefacAef6lGW6
	R1viA
X-Gm-Gg: ASbGnctPpG74ucUDQUSA4WnIMFcOgCekSkCHH1nNIvRlYf1sLAaaHCvrA2fEPHGzFT8
	y+he1SQlUImBDa74GjzsRNUppM9AKdyF/povJkC/CvdG76xMPWCB+ca3/QKlv0Lqnb3jfUC43jI
	xHcTrkzpY66rnqdO717DCOYMSzF+nOgS1hZjFGnR4+z4CurxJ9zbF5phUeRTuiLOIltKu5SCJMh
	lb1Srgpfk3Vwwo+LOABooa0CO10R395BdZb47SS6TsDwsUflOiDd+A4BVBC+RQj8Mpw+vz5kJn2
	N+nWi8/qobz++BHNIhP/WyZ2t49BPD78LyA8ZgpoPKKZiYAzOaajb2utyCR6wsRfOqHSuxXihfH
	XOi4N
X-Google-Smtp-Source: AGHT+IEznRFN+v3XI3jGM9Ru9oV+gJBhWvSvkSFsjdr7OhTJcJllnMHvqZdwRHtoNo20TazQW+1BtA==
X-Received: by 2002:a05:6808:3092:b0:40a:5765:eee2 with SMTP id 5614622812f47-40b057c206bmr3084065b6e.21.1750864981552;
        Wed, 25 Jun 2025 08:23:01 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:1fca:a60b:12ab:43a3])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-40ac6d11be3sm2252005b6e.37.2025.06.25.08.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 08:23:01 -0700 (PDT)
Date: Wed, 25 Jun 2025 10:22:59 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: sebastian.reichel@collabora.com
Cc: linux-pm@vger.kernel.org
Subject: [bug report] power: supply: core: convert to fwnnode
Message-ID: <285c9c39-482c-480c-8b0b-07111e39fdfe@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Sebastian Reichel,

The patch f368f87b22da: "power: supply: core: convert to fwnnode"
from Jun 8, 2025, leads to the following static checker warning:

	drivers/power/supply/power_supply_core.c:215 __power_supply_populate_supplied_from()
	warn: 'np' is not an error pointer

drivers/power/supply/power_supply_core.c
    194 static int __power_supply_populate_supplied_from(struct power_supply *epsy,
    195 						 void *data)
    196 {
    197 	struct power_supply *psy = data;
    198 	struct fwnode_handle *np;
    199 	int i = 0;
    200 
    201 	do {
    202 		np = fwnode_find_reference(psy->dev.fwnode, "power-supplies", i++);
    203 		if (IS_ERR(np))
    204 			break;

if np is an error pointer we break and then return 0;

    205 
    206 		if (np == epsy->dev.fwnode) {
    207 			dev_dbg(&psy->dev, "%s: Found supply : %s\n",
    208 				psy->desc->name, epsy->desc->name);
    209 			psy->supplied_from[i-1] = (char *)epsy->desc->name;
    210 			psy->num_supplies++;
    211 			fwnode_handle_put(np);
    212 			break;
    213 		}
    214 		fwnode_handle_put(np);
--> 215 	} while (!IS_ERR(np));

So I guess this should be } while (true);

    216 
    217 	return 0;
    218 }

regards,
dan carpenter

