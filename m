Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12800FD80
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 18:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfD3QKM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 12:10:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45398 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD3QKM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 12:10:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id e24so7277667pfi.12;
        Tue, 30 Apr 2019 09:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8GdBSdS8QndD/ZLVZE8zKkg0cfJEjJX1CoiB2a13sLs=;
        b=gvXTpUDLxw0Xwd+vX3ZMoMUPAw2gvk5RpdVba+16D8dvMVhi0r0BSY4egykHOOLNQJ
         425yCtL9AnXPJljoFpxU7wR8UPoeEPViRVlXUGwruHVJlAL6glFPEiCjFWHaJZuFxRqQ
         e4vkk++SCi3orIzCF16QgzX3cMAZlBSKlIqzJkiUGfHveC3oT/AHh8ZzH04R3m5VQnYn
         MSVc9psV+raeTE5uC6ccqTP0/ePb/EweMkFOx0iiWQ87A7lurWm8DCoyaQfWlaYmi+V9
         HqBLWX+Sc+bjp0tveufu+bItEaPSQcQbuIWpvxkxLmgVRsD77er0EY2XBuTOK9vX3zG/
         X2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8GdBSdS8QndD/ZLVZE8zKkg0cfJEjJX1CoiB2a13sLs=;
        b=Q+NHxWuJE1uX6/uGEksVmv9CeUsL/qGM592LvfqIsefP1CZbvr3xFpxO1Gg3/PdM1M
         Ia43GBjQ/dA+s2/Mf/torIWO8MgkdTwnqtTUxOlZN2XqCEe01cLQW3Me0of9gu7EyBYO
         dCvZUfoTlQTlZICiXrgfraOiYOB/8+5nh319yji5UYtTKwK1PmqNFFspVgCnCqfOMcPv
         z4CJ3XW6r2prsO3+NUYqiuAUYOgTrA1k2Pwjet3x5jkuGoyC8ggO+yeMda16zffCMsBU
         S1wc5D6jKsYQAoHNn2oCyCwglpx0ZKkSf1QmWDHaJRNU8ELPrNGobUY/Lb8VslV/Lr92
         2i1A==
X-Gm-Message-State: APjAAAVy1dwJmuWGKcPElXSA+7X36LhpGPFzSJFY8BAYYpmGw4qkMI19
        T1HxlCwWBZs0+3m5FHyeSck=
X-Google-Smtp-Source: APXvYqwG2VK1pxY4z7PobpHUSgQI3HIsh9tA2GOsvojPz5mZIzj2swWmY/X6Y30Dqfzc/AWbmZTnZw==
X-Received: by 2002:aa7:8c84:: with SMTP id p4mr53368511pfd.164.1556640611430;
        Tue, 30 Apr 2019 09:10:11 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y10sm52867263pfm.27.2019.04.30.09.10.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 09:10:10 -0700 (PDT)
Date:   Tue, 30 Apr 2019 09:10:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Enric Balletbo Serra <enric.balletbo@collabora.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] power: supply: Add driver for Microchip UCS1002
Message-ID: <20190430161008.GA731@roeck-us.net>
References: <20190430064557.28469-1-andrew.smirnov@gmail.com>
 <20190430064557.28469-3-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430064557.28469-3-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 29, 2019 at 11:45:56PM -0700, Andrey Smirnov wrote:
> Add driver for Microchip UCS1002 Programmable USB Port Power
> Controller with Charger Emulation. The driver exposed a power supply
> device to control/monitor various parameter of the device as well as a
> regulator to allow controlling VBUS line.
> 
> Signed-off-by: Enric Balletbo Serra <enric.balletbo@collabora.com>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
