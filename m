Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397DD77CC48
	for <lists+linux-pm@lfdr.de>; Tue, 15 Aug 2023 14:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbjHOMFR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Aug 2023 08:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236978AbjHOMEs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Aug 2023 08:04:48 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A431703
        for <linux-pm@vger.kernel.org>; Tue, 15 Aug 2023 05:04:46 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe44955decso6185487e87.1
        for <linux-pm@vger.kernel.org>; Tue, 15 Aug 2023 05:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1692101085; x=1692705885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZNL+lyJXlDowNIbWWyMureRuKR8rAj9k/oL5v5izxc=;
        b=blx3s3KVk/ndOnqHTKt1sHABOS2zy30PgIpcc/O3edhtSyYXL+U1vhVumuylgW5tns
         PKn3ytyiaJ6ytk2jEB/9Y/J9r5dk+ECrQ8vP4fej7ZsaU90zLfEL8c5WI+Y+8xWL7GW3
         KswpYBcmpN6pV/a+B2pCHEfuxyWJUCwAjpH2mPtA3biPXRAtjZpn0IFqE1E899EVbR7n
         Y/ODrxDrHnG5GIrN6lh+n36NQgDf4TBZ4lF1rmh+YNoBvMi5vs1ccqgom3bKi+Yllnvo
         FayWUVMZFe7cgqXwrjm8M2RKP8c7WkbJPnMmhNfF99W3HC5Apb8ulBsdcZ2u/0pdbAe+
         JiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692101085; x=1692705885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZNL+lyJXlDowNIbWWyMureRuKR8rAj9k/oL5v5izxc=;
        b=MoOKBX2L3Ha9QspCOGePEwqy4OMErtTaCqUvYE5c+xvYVtwYp8Q2hkkJarUCMw7Ugc
         V1+3BtCGoXJ05sYkZ7kk2ZcHXW3hI6Pcn7z/4MFjJ/RCFm+QUDeqfeSobEe/rP+0qgHE
         HemsnzPoZcYRGJsEXq5MfaoDi0wYI9tCQ3d4k1sbPkwD02PHwV4R98mHImKk4c83Hw40
         gmyF9My9a9xx+hiukjfGadV5ZRrQr9J+L/0sEeefcuehjVACsKk2Rt0P5IDwYWE/D4Qm
         KFb0ambmiDTPliKnBEbsmTOIWMLGuiMqiSBhOO8ygyfoYsNdxClFhtwvlud1aQhk0jGE
         nWOQ==
X-Gm-Message-State: AOJu0YzqA5rvH8FtF3Adc6U0FyAYQv7BA0WiZbLzjR26XisnqOONjxAo
        KSQQJdOHlvA62Ta5PXo5ddz55rtSPcObUKI4vp5Jug==
X-Google-Smtp-Source: AGHT+IE8gqnACIFDnu3Op7a3XdWdZvfD0AG054fdNXDttJp1YBYTEtCJFVXxXzSJqp5uo73PYYcNwsR3tNOjvzRqhzI=
X-Received: by 2002:a05:6512:710:b0:4fb:103f:7d56 with SMTP id
 b16-20020a056512071000b004fb103f7d56mr469965lfs.14.1692101085051; Tue, 15 Aug
 2023 05:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230814181823.3662-1-aboutphysycs@gmail.com> <20230814194335.GV1428172@hu-bjorande-lv.qualcomm.com>
In-Reply-To: <20230814194335.GV1428172@hu-bjorande-lv.qualcomm.com>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Tue, 15 Aug 2023 15:04:34 +0300
Message-ID: <CAH3L5QrLyAHyA3zdtjM7+eNQk5vExq=d9LWaOegXpv+-6s4Jzw@mail.gmail.com>
Subject: Re: [PATCH] power: reset: qcom-pon: removed unneeded call to platform_set_drvdata()
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Andrei Coardos <aboutphysycs@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, sre@kernel.org,
        konrad.dybcio@linaro.org, andersson@kernel.org, agross@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 14, 2023 at 10:43=E2=80=AFPM Bjorn Andersson
<quic_bjorande@quicinc.com> wrote:
>
> On Mon, Aug 14, 2023 at 09:18:23PM +0300, Andrei Coardos wrote:
> > This function call was found to be unnecessary as there is no equivalen=
t
> > platform_get_drvdata() call to access the private data of the driver. A=
lso,
> > the private data is defined in this driver, so there is no risk of it b=
eing
> > accessed outside of this driver file.
> >
> > Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
>

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>

> Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>
> Regards,
> Bjorn
