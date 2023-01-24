Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736D9679D10
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jan 2023 16:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbjAXPM5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Jan 2023 10:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbjAXPM4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Jan 2023 10:12:56 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F681FF13
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2023 07:12:55 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id m7so543657wru.8
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2023 07:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+qrAjBwfzacLHZcDLSem7cYqjezsfIssgjyVtcj5ml0=;
        b=dMpVtOKBFVlhsczGxt2WUhFC8nr2lxvBUOJbbWkAdP98/iFiOOUnifLb7r5m5J/bbK
         5jO2M1NNr/qWF9ZUBbjX+LHvC4ejcX8RHRE8fDSDD7T/Pki3FfVm8D91rzSWbh6/8QD/
         05cJnoiVunPeFHcwuffIcEKneZgEjTnu2yfPm5jWHKz1SuXjkfglMxMCV4sZEPTXlr6B
         EI8BMfP/chkf93MKOt0pxwioJv1WaaK/6RNN0bdb9RzkAf8t9tYYwvwboJd69gLrPGSC
         9iKIj1VHRxJPQ5UDPlR3qt3YldkcCs8a6464GpbWMeiCKCZT/TrqLsesjvw+KXXSkkw1
         P77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+qrAjBwfzacLHZcDLSem7cYqjezsfIssgjyVtcj5ml0=;
        b=0Vi9hotIMo+sdsW1iR86bdOp0HKa+hUa9NPuz8w/vjTYMjssUSaKRzD4Ediek9zT2b
         PL8vYASqMtveHgPkP1xKRW0WYj3MkJWvOQaLZG5R7DIdn5+m1fsax2ZvHFRKBO3Hc8wD
         9C9M2ctND/GAH5vv5shapL0lMzJr4al7+8Dn0W7YoTxJQIXmPqS2Z5dyxcvr4i2r71BU
         30RGNo1wTaxZkRNEkcUqtmT0C2ZdloBhzcU0o/FuNpJgeyeMUmLgxkmD2EGplxfSzFaM
         9+6dFsSFL/2qdhXaNj61ZKp3I6aZ50RmT2shz8jSa9rt5UPzXxy2c9YZ1yv0As6nJinN
         Sa7A==
X-Gm-Message-State: AFqh2kpU5knyoKDYBsxLKO4tiLmaEgs5KmV+8AZTHSnpc4z81Ch9FGC1
        BQ+qaYVoBXNzq6TImqn+m30=
X-Google-Smtp-Source: AMrXdXsaEzOS6d3eoCLPnagAxJLMQAwzpkCKtOXD+lnlUboG5gmG6LiDRa33EqCykwagRSF0nbiB6g==
X-Received: by 2002:a5d:5087:0:b0:2bd:e007:c54f with SMTP id a7-20020a5d5087000000b002bde007c54fmr24520022wrt.57.1674573173888;
        Tue, 24 Jan 2023 07:12:53 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p7-20020adff207000000b002bdff778d87sm2120970wro.34.2023.01.24.07.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 07:12:53 -0800 (PST)
Date:   Tue, 24 Jan 2023 18:12:49 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org
Subject: [bug report] thermal/drivers/intel: Use generic trip points int340x
Message-ID: <Y8/1ccQLn41w+Vek@kili>
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

Hello Daniel Lezcano,

The patch 0d568e144ead: "thermal/drivers/intel: Use generic trip
points int340x" from Jan 13, 2023, leads to the following Smatch
static checker warning:

	drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c:137 int340x_thermal_zone_add()
	error: uninitialized symbol 'trip_cnt'.

drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
    127         if (get_temp)
    128                 int34x_thermal_zone->ops->get_temp = get_temp;
    129 
    130         status = acpi_evaluate_integer(adev->handle, "PATC", NULL, &trip_cnt);
    131         if (!ACPI_FAILURE(status)) {
    132                 int34x_thermal_zone->aux_trip_nr = trip_cnt;
    133                 trip_mask = BIT(trip_cnt) - 1;
    134         }

"trip_cnt" not initialized on error path.

    135 
    136         int34x_thermal_zone->trips = kzalloc(sizeof(*int34x_thermal_zone->trips) *
--> 137                                              (INT340X_THERMAL_MAX_TRIP_COUNT + trip_cnt),
                                                                                       ^^^^^^^^

    138                                               GFP_KERNEL);
    139         if (!int34x_thermal_zone->trips) {
    140                 ret = -ENOMEM;
    141                 goto err_trips_alloc;
    142         }
    143 
    144         trip_cnt = int340x_thermal_read_trips(int34x_thermal_zone);
    145 
    146         for (i = 0; i < trip_cnt; ++i)
    147                 int34x_thermal_zone->trips[i].hysteresis = thermal_acpi_trip_gtsh(adev);

regards,
dan carpenter
