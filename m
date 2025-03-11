Return-Path: <linux-pm+bounces-23824-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DC7A5BACC
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 09:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2B2168129
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 08:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B612248AC;
	Tue, 11 Mar 2025 08:28:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4732C33E1;
	Tue, 11 Mar 2025 08:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741681698; cv=none; b=GPtgptDkUeK9LwjsecF48zyVZ8xWlvNWwu5DK2OYMbDggBItuHBjvZVUTKP/aJxC5QQMHdgLzXohdiGHAJPkLNx23ZGsfiDZBHuE/9cFlNhLtaKbpGj1zPPWRN2WFctDLa1P/yofvdIhwQJ0r4Y7vEXRoS4uXJveEB8LSHMkjAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741681698; c=relaxed/simple;
	bh=pQQFcvfVaQvEvbiIt4cCXjYx2eaw+CECMxZNp19aYRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZIO52dwOdN67zNa2CLKcQot9+N0bX/RLXPnMHiGGcx8P+1R+iDaFQ8eTrdSota5JlJiOu1gFNX0jCUCY1KQSIuWfq29HwVTHZ/fgQ+ueWNDhL/XCsWqKzl23qWacPhZw9owLEyNj3ZFGBz9mD7A/V5di4RXQINwilN5Nru9/wBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-86cce5dac90so2279645241.0;
        Tue, 11 Mar 2025 01:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741681693; x=1742286493;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j9asmBtW4ykGHIYyDIqC+wQbre8tc3Kb8DUbwi0bX30=;
        b=dgENlN0Ht05O2k6WPCd1qewkkmupqNw0KCu/Q6q+xdOLX+r5e/Wc4xg3jTQ6W58Y5+
         2pp+fxWVOjnAW9D+Kmeo1NmeFQZANlFykyhSeyDwmTs/B8dnnGywhuZ5VojNyDhysJTY
         yexs63PyHwTYe6/KxErOpQa7MSvXh3fOf2CkNdlcjGUXgCDCq8UTSFabxy/wPbqNsVsU
         UXAnwLcLnWsjSXvp/TlAOne1eLaGk6ivxCSQ3Ul3qmAPGEwprAs/HiL7v/schgmDJOgM
         4prnhRs4g3qZbG0DRjEf/6SO3Nn0UDL7EbC+CyZdWqXckqNHflSfwjushjF3OBtvK106
         8lYg==
X-Forwarded-Encrypted: i=1; AJvYcCUucFtZouhXLCYBpX3U/SVGrsiqW3JhRoNv4XlhT+V2VtsDW5IlDCuU425z1IHQXZ7r8Ch+RzW1I2WNhgF/@vger.kernel.org, AJvYcCVslimWRkBT7Qw0SIID6iEs7MFR35e62uHGXriohn6hZ9atR35N0fA0qQO6Q+MGXzh4kTDlyVyNvjKIg3f6pB2c3C8=@vger.kernel.org, AJvYcCWdKebMrv1lWOfeuLFE/lICrz37IbNWNX7Xj9Xjr1QgUmS30S2s0QIma/tskxA3942t4sUtaTBRm/o=@vger.kernel.org, AJvYcCXjWXJ/QjBiPWWGfrCclEhYYUmPggLdRIdo1WpypgtM/9OGjcLQPNWBAuwZoFsSVUbQ6gUwWLNH+zLX@vger.kernel.org
X-Gm-Message-State: AOJu0YxzhYfCJbZnYYi43oCKm6uJnAAJ/87G55X7FKkIpZaSCl/bwBj+
	+eQfaVjVmPBQejGPNm1cte6cnSlmoTW9Tnrk4nRS9XJV5rlaDFvd/ZRtQqfPnb0=
X-Gm-Gg: ASbGncs5XmLRd8uuPPtsVU38TlYsmJ8YphahPyeVoUiSHLFDXN5iftzgFUb6UU4I4pO
	mV2dZ3MJXvVzOQ9f3XU1M8BBCmGHB/MAfpKPep2gD4KZGUFgvxmK3NPL0FjF72EKMrV5dRWkUCG
	ZFZechKEG2P88WWfThVIiE8LXhivV1NcJMDjPzDIbF4iRifMDBEa/wFxQaxwwf/cAmQdp+iaWTS
	cbwevdyXBZjuRlctZNS2YnJH5Iv/aRjO6AYfvXtkCvbsFyCl2ABzQ2z2jqebQ6AcmNL/DS6BMXf
	OPMJG5jN2DzMlQXdvrvILPUTCkhC73SDQGAj9lISRTxuo1SwxGAYWZ2uVqY5vRzvTtSU/rlBhla
	oGSyR14WJ7As=
X-Google-Smtp-Source: AGHT+IF7dek3btzRXn+xNvr86jfhDDhmeoxJc/aKT5VNzzuyIyOrasaF+Ad8ZY9iHS8OuRPjapVU3w==
X-Received: by 2002:a05:6102:374f:b0:4bb:c8e5:aa8b with SMTP id ada2fe7eead31-4c30a6e424dmr9602329137.22.1741681693472;
        Tue, 11 Mar 2025 01:28:13 -0700 (PDT)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86d33ccba8bsm2199817241.34.2025.03.11.01.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 01:28:13 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-521b84da5e9so1867440e0c.0;
        Tue, 11 Mar 2025 01:28:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2Cwpsv83mRNRogYqto8bbJScLn3QMp7Z5S7aCPWMQOdePfwoPa3rbVr4V1bU8eKApnP54dhlJa+Y=@vger.kernel.org, AJvYcCUGeHTldYSdzc49Ki8ZBsWdH+8WeCph3qy/fur8OaVmGXYbyHRP+CAiOyNEi3d0QQHQk7E5LftaMF/7iom0fOBtdqs=@vger.kernel.org, AJvYcCWehXrENu2Sylwl6o1sujMaro9UmoWVNjWgoPIDGk70x8dbk18jom8E/b72Q7+Ia0AgF+QjCr1mXvhEAkQK@vger.kernel.org, AJvYcCX+zr40TBwrnzbAC/eaZt18iLRw7oBJnCYAMIyEez5aK2b09QLKhh6kb4dNEOsJH6+A5hoSHNkHQZ6R@vger.kernel.org
X-Received: by 2002:a05:6102:3e16:b0:4bd:39a6:e98d with SMTP id
 ada2fe7eead31-4c30a346c43mr12172307137.0.1741681692988; Tue, 11 Mar 2025
 01:28:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309121324.29633-1-john.madieu.xa@bp.renesas.com> <20250309121324.29633-2-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20250309121324.29633-2-john.madieu.xa@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 11 Mar 2025 09:28:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWV7CNBJbPKpymBvvQTbHcpSYFA7DfbOr27CRwwGxh18A@mail.gmail.com>
X-Gm-Features: AQ5f1Jr5Xvuhwpg52kNPydAXsbsr-Q6lxsfd2ynCdmDZbt4PEMDZP2P4hNDUS8I
Message-ID: <CAMuHMdWV7CNBJbPKpymBvvQTbHcpSYFA7DfbOr27CRwwGxh18A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] thermal/cpuplog_cooling: Add CPU hotplug cooling driver
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: niklas.soderlund+renesas@ragnatech.se, conor+dt@kernel.org, 
	krzk+dt@kernel.org, robh@kernel.org, rafael@kernel.org, 
	daniel.lezcano@linaro.org, magnus.damm@gmail.com, 
	claudiu.beznea.uj@bp.renesas.com, devicetree@vger.kernel.org, 
	john.madieu@gmail.com, rui.zhang@intel.com, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi John,

On Sun, 9 Mar 2025 at 13:14, John Madieu <john.madieu.xa@bp.renesas.com> wrote:
> Add thermal cooling mechanism that dynamically manages CPU online/offline
> states to prevent overheating. It registers  per-CPU cooling devices that can
> take CPUs offline when thermal thresholds are excee and that integrates with
> the Linux thermal framework as a cooling devices.
>
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/thermal/cpuplug_cooling.c

> +static int register_cpu_hotplug_cooling(struct device_node *cpu_node,
> +                                       int cpu_id)
> +{

> +       hotplug_cdev = kzalloc(sizeof(*hotplug_cdev), GFP_KERNEL);
> +       if (!hotplug_cdev) {
> +               pr_err("Failed to allocate memory for cooling device\n");

scripts/checkpatch.pl:

WARNING: Possible unnecessary 'out of memory' message

and checkpatch is right, as the memory core already takes care of
printing a message.

> +               return -ENOMEM;
> +       }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

