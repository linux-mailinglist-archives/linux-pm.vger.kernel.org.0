Return-Path: <linux-pm+bounces-28830-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B155ADB2B0
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 15:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 611757AB9DC
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 13:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB0B2DBF79;
	Mon, 16 Jun 2025 13:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="RtBmYFvs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA692877FA
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082048; cv=none; b=S3yaFlq1CXy8cdHHjiUz5K//iYZsqQcgXBTfcPAaSNegnx3mDx+0Ro5ut86rh4eVvJ7/neioGVK6sjdL+ik3J7zYst9A8VVHtrIS9jaV1ds3EWOQvQQ/mbx0RLi6pcdzJHjC3M6bYSegF32LtoosvE8031mjNBZ9iGwImdJ3drE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082048; c=relaxed/simple;
	bh=WdYsA4gcGJ4whUTHaU62r1/1/AwXMOqpKKD02j5KM2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LGKIUbRrw/FvgSpf4Trgdm54qSSy5XabgNojlaerU4O2/KogV1k30HIXWXNTLMPQnyikreE6g9CGmH9suvBxResIUGApLNcXC7gY9ki27htrBKlEm+ZFrV+mn0M3HpbD51xXHUNynVUpOdSwEAhOYzZ1HMZd1CHobRVivXgyIHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=RtBmYFvs; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-acae7e7587dso690205266b.2
        for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 06:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1750082044; x=1750686844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xJCI+6qwU3+gkjXsqHZde1TYEMyw88mnCNmjbKL5ih4=;
        b=RtBmYFvsW6Vw+ZL7FzFrE7wKDDtpCgAP3oBtY45llLJtfuIX5KB6kx+wl6KUVXW0wk
         AdjTflrSENkq8zVE1hn0C6SP7zMnPPh1FgAIiYI9Jranwe2S5LUJveuHvb2UrJYzH/eq
         ti2Lp0fuYXFr17hqjopDJRft1CSGHtXGdpyEIDoKKCYZP3FgOyha8/l3Z6oNimZ3doeP
         MBp12iEZovAIAA2B5T80taXplc7XWAnBMHZz8RWe49gY02aUOZBJ91mgYTftvKMFrQRu
         YvcI4G22TNevck4mSmfYTuwWsipLdgBLZBqy2PImcpD7i60AQA0wQ4lerrYyHpWIg39B
         Xa6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750082044; x=1750686844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xJCI+6qwU3+gkjXsqHZde1TYEMyw88mnCNmjbKL5ih4=;
        b=o4/iVw4dbmS1OtvBZd1pey3qW93ROcBIQSkoBvgBOuhSzu2YTnmc5JOFBXc0dhACuI
         4Ut+gifcKQF/vr5sbMbXtWsjNa7Q7ZEs3fa4yilndah31EMDcl9xys/RYjy2RMX3h4In
         fkC9bW34uETgRikZNqulIfAenciU+SFxXsb+7NRw2BQaED0W6kwiDS/8VNc6G0e56GKI
         UZ8s677jIdtI2Ww/gnHxeCqAuPhWaLF04t9gRJArusoUlovu4DH9Kq00GLW6zv5Pci0p
         s2KIjwgx3PUve0T5W9WbcpKij5BBULE0di/i+XghvE7aealpdppB9ioxNWdPOnwGOQPf
         a2kg==
X-Forwarded-Encrypted: i=1; AJvYcCWIRSf+edqgA76nrXYnHcW6RFCLAKoCEUhWBBEyukwpA7fCjmR2uajqZHNjuAQLr/BMuV4g/+tmDA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+yyk0N8eltoHSI5+fCIGOuT3Wv4NqNlyJZ9hTpJR/7Sg/89oK
	WTCuo3q6b5OqHbaO+I1nKSQir0OPSU8roZ97NH99F6MIBkWJkeC1+2s1wMMA9MxjhWw=
X-Gm-Gg: ASbGncug5z0kQkSTkdZOvbrJnp8umlCE+B7tFDoG6EtcHGTfSHDWArH9nAULaDanpUs
	/Czt9OHDIKssy/H+ECTpPIRiRaofXe0n6yCvIG6H0josaU2St613IkiXwW0o9AVe8uP6eVm869S
	kLeJ4yVJM3+dqSKcv+2w6WcbOoQl4xTS/qIPqt45E0WirqYfRYKeq5bCovfvFutrNaFz0MlgVXy
	8fQq+fjUFXazSNKZMsHnLcfk+2cgx5k7mUkzUZ42JBoN/TcwKoQZ/tVJMdGoGqKvkfM8UqxreRi
	yJRKSDd0GTEd2ZYYOab2e8BROeEfsMCe5/J6nbLh2I1EVz8/3gt6z1oHzQA42+DmIfk8m+1DqNL
	Mmq0xiu2QknKj8rP7
X-Google-Smtp-Source: AGHT+IFIEkskkJG9WLW+Hv9ZKWW2DbdD0zYs82b6WVAC9yGzm6OdzcpBZetxbCKgKVtLW2Au71dzLw==
X-Received: by 2002:a17:906:c14c:b0:ade:484d:1518 with SMTP id a640c23a62f3a-adfad38b235mr948743466b.26.1750082044401;
        Mon, 16 Jun 2025 06:54:04 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec897a70bsm662748966b.154.2025.06.16.06.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 06:54:03 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org,
	ulf.hansson@linaro.org,
	jic23@kernel.org,
	daniel.lezcano@linaro.org,
	dmitry.torokhov@gmail.com
Cc: claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	bhelgaas@google.com,
	geert@linux-m68k.org,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	fabrizio.castro.jz@renesas.com,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 0/2] PM: domains: Detach on device_unbind_cleanup()
Date: Mon, 16 Jun 2025 16:53:55 +0300
Message-ID: <20250616135357.3929441-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series drops the dev_pm_domain_detach() from platform bus remove and
adds it in device_unbind_cleanup() to avoid runtime resumming the device
after it was detached from its PM domain.

Please provide your feedback.

Thank you,
Claudiu

Changes in v4:
- added a flag in dev_pm_info that is saved in dev_pm_domain_attach()
  and used in device_unbind_cleanup()

Changes in v3:
- add devm_pm_domain_attach()

Changes in v2:
- dropped the devres group open/close approach and use
  devm_pm_domain_attach()
- adjusted patch description to reflect the new approach

Claudiu Beznea (2):
  PM: domains: Add domain detach_power_off state
  driver core: platform: Drop dev_pm_domain_detach()

 drivers/base/dd.c           | 2 ++
 drivers/base/platform.c     | 6 +-----
 drivers/base/power/common.c | 3 +++
 include/linux/pm.h          | 1 +
 4 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.43.0


