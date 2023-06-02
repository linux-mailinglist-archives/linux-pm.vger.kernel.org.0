Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062E471F76E
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jun 2023 03:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjFBBBL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jun 2023 21:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjFBBBK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jun 2023 21:01:10 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC60E4
        for <linux-pm@vger.kernel.org>; Thu,  1 Jun 2023 18:01:07 -0700 (PDT)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E2CE23F555
        for <linux-pm@vger.kernel.org>; Fri,  2 Jun 2023 01:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1685667665;
        bh=wCbPB1ZDTWLt/oEJv6P7qx4Cdd8dnV7Y9TrZ5aVJ2o0=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=qf/XcOkaa1ZekfrU8e8pefIvLAuErEBq2vbDuJeLl8UfohcxPbe53BJdfDpOaKIzc
         3qRU+g4B1JsDXDPhbh90sNjTLaj5i+nwDJm1VJ0+HzUKXFjgfLx4nm/ycnHVD8Y4S9
         XRW+jb9MagLpnuaBrpEceiDDB/W319ytSabXGMyavt8guDZF7yTbMlJHvGu4qBbPMt
         1PLRK+TJNUBKBuKyZJA0ZGzT9u71UlUk02E6+Mx9dY3cl6oL745QR+VQCuBdw2U1y2
         0uB+z+iW0Ofu/T04g9FzsTlSeMlpmAjV6F0UFmJ7+ic8AXIyg09xQBN7SomdQu16Zl
         ZURwHdFUk1h+g==
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5428d1915acso294655a12.0
        for <linux-pm@vger.kernel.org>; Thu, 01 Jun 2023 18:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685667663; x=1688259663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCbPB1ZDTWLt/oEJv6P7qx4Cdd8dnV7Y9TrZ5aVJ2o0=;
        b=EOaL/QaGfDy7GhA1vAPWsTB721K2VFmnj3LbiFvw+A0JrTi7AQUm1xV6w1Kg1d7Ap4
         39mUjb09PiWkpF9gNmOsU1THVQ1oep510tInjCaRYbChrv3slPheZuY1kyprux2Iogb/
         uuozuib2uPiHLnbWy3UVx4j4lI4sQHLbIvJ2Ui5sA17eDDn1H3gB3FjearkZ1lk8NGGQ
         qKGU4weRbxIWDXue6JUy+NnhrgLM1/N22aoro6XubWxrTmVcNLJ3/hC6r4f8lbvuiIvG
         ypR3LZx0DQ9c37M7cQH6t6R2MNaaiLizqlBtLaI1lc+H7+Vcg6PXg7t/fbXvoaZQVCHj
         niXg==
X-Gm-Message-State: AC+VfDygxAoagAi1l7xKUv6OH8Bo8SK+Ybyit6mzntnTuWKwVxa9ARN8
        sDoixnDWuw8IB+aQTiY1okFx5Tk/V88gRGj1/cuftEB5eD5uTlj8xHwPW5aCMkeeOyPPmCUqwwF
        4E9pUeBON0EXJlYCKVQIQ5L653dQ+xrhvKu6M8mlWd3Rvpt2AkD9U
X-Received: by 2002:a05:6a20:101a:b0:103:b436:aef7 with SMTP id gs26-20020a056a20101a00b00103b436aef7mr3265570pzc.16.1685667663269;
        Thu, 01 Jun 2023 18:01:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6VYL0KZ+3iS8gCc9F1FccQPyYsJMympHRukppGkxqbJhX/s/Mr1+03VnVxAzE9Sg4EziYgwHd5k/dOBTS9O0k=
X-Received: by 2002:a05:6a20:101a:b0:103:b436:aef7 with SMTP id
 gs26-20020a056a20101a00b00103b436aef7mr3265549pzc.16.1685667662942; Thu, 01
 Jun 2023 18:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230601155652.1157611-1-kai.heng.feng@canonical.com> <164576ab-4e68-ca5d-0c9e-d756588cdbb5@acm.org>
In-Reply-To: <164576ab-4e68-ca5d-0c9e-d756588cdbb5@acm.org>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 2 Jun 2023 09:00:51 +0800
Message-ID: <CAAd53p6S=nzxgwBky6daJZ8wa-HaBODpjwLPYZ52g8FPXbbACw@mail.gmail.com>
Subject: Re: [PATCH v5] scsi: core: Wait until device is fully resumed before
 doing rescan
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com, dlemoal@kernel.org,
        bblock@linux.ibm.com, acelan.kao@canonical.com,
        linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 2, 2023 at 3:48=E2=80=AFAM Bart Van Assche <bvanassche@acm.org>=
 wrote:
>
> On 6/1/23 08:56, Kai-Heng Feng wrote:
> > During system resuming process, the resuming order is from top to down.
> > Namely, the ATA host is resumed before disks connected to it.
> >
> > When an EH is scheduled while ATA host is resumed and disk device is
> > still suspended, the device_lock hold by scsi_rescan_device() is never
> > released so the dpm_resume() of the disk is blocked forerver, therefore
> > the system can never be resumed back.
> >
> > That's because scsi_attach_vpd() is expecting the disk device is in
> > operational state, as it doesn't work on suspended device.
> >
> > To avoid such deadlock, wait until the scsi device is fully resumed,
> > before continuing the rescan process.
>
> Why doesn't scsi_attach_vpd() support runtime power management? Calling
> scsi_attach_vpd() should result in a call of sdev_runtime_resume(),

It's system-wide resume in this context, so it's dpm_resume() waiting
for the lock to be released by scsi_rescan_device().

Kai-Heng

> isn't it?
>
> Thanks,
>
> Bart.
>
