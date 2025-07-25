Return-Path: <linux-pm+bounces-31414-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44730B117C8
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jul 2025 07:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC9423A8BCC
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jul 2025 05:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775AE23D287;
	Fri, 25 Jul 2025 05:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQFelfGo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99AE48CFC;
	Fri, 25 Jul 2025 05:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753420028; cv=none; b=lGEhpAHZ7MVVrn1MX1QUaexN0L/xNpukdRSssv18wi6s12keDyBhzAXlYKPMaJgRiYge0dTp4uGicnlIorbaUWyQUjAB93PWtrWf8QY/7xdtAhEJWWPtWim7SbvxEn6UFFxLsUOJlRLJ6lLhaDT4xDzYIDrA/5laWm0EE324W00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753420028; c=relaxed/simple;
	bh=Ib5FE0QoMMNdFpBA0yVOTPTmH+AZrc74xbL0n+1+S+s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OxnnRDQR3ITLc/yCAm9DZr+9Ikq/pn02zcC69ayqBr/wh1tDwqB82+D0qEdhibCK5mrx3leBmbB8ztU+A0VomWM+ALRBgn94jT6KC6Ir4H5hbRtE8CZ5XwR+82NroMuMDtTh5hOakgNrLyCNobIq5ChKpnW2p+GEn6iaALKPlyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQFelfGo; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6fae04a3795so13881746d6.3;
        Thu, 24 Jul 2025 22:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753420026; x=1754024826; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dRMBoFJ15p7ZT15ip7Hrv1Ml72IqtNL3iXOUPGAitWM=;
        b=DQFelfGo7d4PGWbxDIGb+PCJvp6qfjQlQ+eg2ILf+sCRY5R8pf4ywlx22q+inRUkUK
         RA5BcSyW+av0p/vnzkzq+DJpQt5hXURjnpL+NdPCKeaZgj9PehSAlUbihUwt4nHCVIm4
         snj3UPN6crP02Sq+7Rr3MuC0Y8sf3bPgHDOlXDwf9lU7AffDOnzgg//yMPRnmRYj2UUW
         rNXrzIRLE+sy0EXGqeT2v47kWIjgJJu0+UsmsThCI3JLeo0R27gmtKQ0wxgSF2aOmIjG
         DIt2FVI55pzx4nqbpupJFzmgvXJJeZiAcsjnN2bzytbixW+XgTk13WeaUoseoF+neP2K
         Olyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753420026; x=1754024826;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dRMBoFJ15p7ZT15ip7Hrv1Ml72IqtNL3iXOUPGAitWM=;
        b=VZ53ghUJSrnBBL7kSUgOIgrd6OkbW52DAUwX4mXCE/hhfZn5oewwdJ0x+ZpTgGfef6
         YvB19ZDkWHYOOn27T/fk15DAgMC9dhM8vky2PCxBTb5y4rYNwK4K/Yvnq/1646msCyCa
         Xt+Mdm1FUSmJ3+0EtoUVuLOfysEgJiKL2BzHzQ76HdVVVSr7XcIrI0Ptl3B5SvNkYQti
         VQS1YCou4IrpF0Owcz0bIVp64WM3UvFZWK1aX4MQ0tl5mAg8xaapZ/hw0/IgnXdWXzG8
         29OT6PbuacSaWTARPjv1Jl6gVKfRoBOlb0fDMUcuhuZ4jJRa19nJ5D8EPU1F6rUqygfe
         K1Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUEZzfDKOyRQJX4oOfGhVMBdV4opIHJWFQA0eB4gtzGPHi1BAcL8FxA7Bcqx5LVLBlOKD2Am0zgQJg8FBw=@vger.kernel.org, AJvYcCW+5kChB10pMZGgRWSNGDfvm753VVr7JuNRr68U2XdewgmJmEN6CmXmibtv0px5YE2B3lsTBRekamU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGIQQU5hCoLAK52NQwL5o8FqSgLG3kuJoHpaURdgqYTti8ulXr
	HvmwXGzKIKgSvwJP7jOEdWqOeBx9uLK7jrSZClAymGHOc6zVKgk9ERgi
X-Gm-Gg: ASbGncs6XaNyCxM60RcBuC5mYz2jSHdk/orKjmELCysGdTp1DPenvJ5yCIdeDO8RD++
	/LtDjty3WALGWrWechNKVvRR0EIWpJfeYlObEGvkAIxMm+Q5yL1xNOYwi7oOFQsnlzhocjxI488
	oeMuT1YoS1ME1DXq0Y511W5TZXIoplg13BObVH9uDPyTUio9y32jjdsRNG7TitFLPjWeMW/W04T
	RBj8Vi4qMAkfnpuwqa85LnAIAIFL89awlEnXs1DX0TN0nvOh1Npi8Trs8+BVGTTjYszlqaSL2Z3
	zqvunZggwq/WsghHd18uAacL2YJDJqQ7aECVE3oPQXgN8WqarmShFCc6iho59CCRzba7a0Y7/Iq
	D+ApiP7UZYgtIjw==
X-Google-Smtp-Source: AGHT+IHYQh1UqAPsmxjHEZ3LJXPXVDx286B6GQMg6QVOuyzTh8PtFKisKHfxCx9RE21vpz1hU/e8jQ==
X-Received: by 2002:a05:6214:2522:b0:706:ebc2:9da with SMTP id 6a1803df08f44-707204e946dmr6510276d6.2.1753420025809;
        Thu, 24 Jul 2025 22:07:05 -0700 (PDT)
Received: from pc ([196.235.221.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7070fb53f7dsm22362996d6.38.2025.07.24.22.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 22:07:04 -0700 (PDT)
Date: Fri, 25 Jul 2025 06:07:01 +0100
From: Salah Triki <salah.triki@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: salah.triki@gmail.com
Subject: [PATCH] thermal: intel: int340x_thermal: Remove acpi_has_method()
 call
Message-ID: <aIMQ9RFciI8jmmAh@pc>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

acpi_evaluate_object() returns an error if the needed method does not
exist. So remove unnecessary acpi_has_method() call.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c b/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
index cb149bcdd7d5..ce5d53be108b 100644
--- a/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
+++ b/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
@@ -220,9 +220,6 @@ static int acpi_parse_psvt(acpi_handle handle, int *psvt_count, struct psvt **ps
 	int i, result = 0;
 	struct psvt *psvts;
 
-	if (!acpi_has_method(handle, "PSVT"))
-		return -ENODEV;
-
 	status = acpi_evaluate_object(handle, "PSVT", NULL, &buffer);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
-- 
2.43.0


