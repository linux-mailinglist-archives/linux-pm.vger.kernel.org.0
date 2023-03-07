Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649316AE4AB
	for <lists+linux-pm@lfdr.de>; Tue,  7 Mar 2023 16:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjCGP2n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Mar 2023 10:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjCGP2S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Mar 2023 10:28:18 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FF426BF
        for <linux-pm@vger.kernel.org>; Tue,  7 Mar 2023 07:27:39 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id ay14so50065241edb.11
        for <linux-pm@vger.kernel.org>; Tue, 07 Mar 2023 07:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678202857;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z0uX/whlfBY3Dw/yAaYswjgwPf2gV7oOjGwRpYic0/Y=;
        b=BVz8SpXz92xaV1wRftu7U2qEZ7m0sqB6VhXj+2DoDmhcQMix7C6LHEQRaTmFbykdmX
         tWwRDxR8raKY1lWcWUL7FCSxk0dC0WKXsq/8JbVF1P7qs114Gj8B/m7POKRPV0DBxK4O
         Zz2npffLxHZ0w5l8asWJK2uDPrhMAtdZefeDBNa6RhPaPlM4xqg47bG3d9ujLLD4nMYX
         OO6FT5mxm73Zu9rLci4XUnMwDLk9UYf6EzHRw4mO6OVhf18YP2n88FbhurHJUEV2oRqp
         h4lyTHrkLZWAiyXXhZb3CnbMl0iCFY566QWNHJ/9+JS1ouCyUrFbApNkyisUeFgLTmsU
         NZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678202857;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0uX/whlfBY3Dw/yAaYswjgwPf2gV7oOjGwRpYic0/Y=;
        b=LiJXUM8a24klffhekbOfIxiCrD33nFZJqXOCQ6XXXM854+f9/3wzr81/K0x8Sr3lhP
         ZWchig0AKNLf3dWTRW8K8uiH2GS9TsZmLdOcQi9AM9rraBcGRW+SrjDymN0NwvEtrDtc
         xjssfFlyXNJn9qHCnE9XrvMTd2OLfwlY4MdWw8YSyIDFpbSqLi8ejGu40i4evuka2gUP
         9+o76Z3b1a51PBlzy47iwjL0Dwa8QuRcZOn3lgsPOm0Zk1F7zbSw/hguY94WWq+w0GT3
         NcLyaFGRVsORGUE1vhDwhV+S2DnVKuSfGp1Nj9rNLtO+YRCp1vtj3sKFXWsp/3ZS2M4L
         ml0Q==
X-Gm-Message-State: AO0yUKVMCm0/Y49MfLCnyd/MKCVnIEIPi6NcF1/u2DqO3Wq4SSbJ8KXZ
        lB/RkcWCs8vPL5MZRlN6Grk=
X-Google-Smtp-Source: AK7set/AbathoqiUH3gHM7f94EPTpm8a66Qf4sgqAVAmxkrDHqNlQNoY9qijUo/NUZx9aKFFdHv8AQ==
X-Received: by 2002:a17:907:6d86:b0:8b1:3d4:6a9d with SMTP id sb6-20020a1709076d8600b008b103d46a9dmr20550903ejc.19.1678202857432;
        Tue, 07 Mar 2023 07:27:37 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e7-20020a170906c00700b008cff300cf47sm6194145ejz.72.2023.03.07.07.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 07:27:36 -0800 (PST)
Date:   Tue, 7 Mar 2023 18:27:32 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org
Subject: [bug report] thermal/x86_pkg_temp_thermal: Add support for handling
 dynamic tjmax
Message-ID: <add7a378-4d50-4ba1-81d3-a0c17db25a0b@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Zhang Rui,

The patch 58374a3970a0: "thermal/x86_pkg_temp_thermal: Add support
for handling dynamic tjmax" from Dec 19, 2022, leads to the following
Smatch static checker warning:

	drivers/thermal/intel/x86_pkg_temp_thermal.c:159 sys_set_trip_temp()
	warn: no lower bound on 'temp'

drivers/thermal/intel/x86_pkg_temp_thermal.c
    122 static int
    123 sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp)
    124 {
    125         struct zone_device *zonedev = tzd->devdata;
    126         u32 l, h, mask, shift, intr;
    127         int tj_max, ret;
    128 
    129         tj_max = intel_tcc_get_tjmax(zonedev->cpu);
    130         if (tj_max < 0)
    131                 return tj_max;
    132         tj_max *= 1000;
    133 
    134         if (trip >= MAX_NUMBER_OF_TRIPS || temp >= tj_max)

There is an upper bound on temp, but no lower bound.  The "temp"
variable comes from sysfs via the call tree:

  trip_point_temp_store()
  -> thermal_zone_set_trip()
     -> sys_set_trip_temp()

    135                 return -EINVAL;
    136 
    137         ret = rdmsr_on_cpu(zonedev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
    138                            &l, &h);
    139         if (ret < 0)
    140                 return ret;
    141 
    142         if (trip) {
    143                 mask = THERM_MASK_THRESHOLD1;
    144                 shift = THERM_SHIFT_THRESHOLD1;
    145                 intr = THERM_INT_THRESHOLD1_ENABLE;
    146         } else {
    147                 mask = THERM_MASK_THRESHOLD0;
    148                 shift = THERM_SHIFT_THRESHOLD0;
    149                 intr = THERM_INT_THRESHOLD0_ENABLE;
    150         }
    151         l &= ~mask;
    152         /*
    153         * When users space sets a trip temperature == 0, which is indication
    154         * that, it is no longer interested in receiving notifications.
    155         */
    156         if (!temp) {
    157                 l &= ~intr;
    158         } else {
--> 159                 l |= (tj_max - temp)/1000 << shift;
    160                 l |= intr;
    161         }
    162 
    163         return wrmsr_on_cpu(zonedev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
    164                         l, h);
    165 }

regards,
dan carpenter
