Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC2667540B
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jan 2023 13:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjATMBO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Jan 2023 07:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjATMBO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Jan 2023 07:01:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBA3A2959
        for <linux-pm@vger.kernel.org>; Fri, 20 Jan 2023 04:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674216022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wx289155CF671v9bWZEVjt9M79byGIA+maW235dB6vs=;
        b=e6rrAWvbY4nB13nCWl2xLwDiclp7phyxvQiVnFJJNuBgUBWEbBq2aa0UIhK562lIFkN3BZ
        4qolfldOKD52zUnP0iXj59bzoZin3/cZhsRUscKaH2QB8l9OGL/qjqdskoQQCEOMtHmRH+
        veHYHoYWORhpRn4f7xvJCTMyxpU/RYA=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-480-cEzV3FblOYWswytrRJm-0w-1; Fri, 20 Jan 2023 07:00:21 -0500
X-MC-Unique: cEzV3FblOYWswytrRJm-0w-1
Received: by mail-pf1-f198.google.com with SMTP id s4-20020a056a00194400b0058d9b9fecb6so2365336pfk.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Jan 2023 04:00:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wx289155CF671v9bWZEVjt9M79byGIA+maW235dB6vs=;
        b=uzUNVu+mUiwLy7Jmr5TRfOHgzDgCj/brUgHsRVBmb3C7dhie/CfvB9UJSZKuBOUuMB
         FMYOTlrRYAkfu1gUTmXNu+pux+J7FoIcuyz5i5UeRWzmbiPtNL9095UmHI7QPWQ0ZZO+
         9eUaWev9zFxvP8NGiqr0KKgbJK9BcQRGoTpeSvcDdkbUHUdexPoggJKIUoMjYsoh3J0R
         0vo9EnD/b9ar/fKiIVZMRi+JRS6OVERTxdD25jO6R3b/WZs8Wv8hUOw/7pS3/J3y3vq7
         C4FM67uHn4iytcTvtuije4ASyISfybBrkeDxFMKf7kOTejbY/q+xxJL1rZYo0kz9QwQL
         /nVQ==
X-Gm-Message-State: AFqh2kofVWscfVBeKZRehpFJGGvKEcIu258sig+0wddkiF/69btWTC9Q
        g2bq4Dt1/a1kKL1kyqLlbzWzbQbIhk7UQODaP1+V61TbfjEKPPsevz6X2L4pkJD5C9bM6yML2ht
        tUoJcu700Ru4r8CvNpto/ys5d8FUdClCEwCM=
X-Received: by 2002:a63:6e82:0:b0:4c7:ac8f:9e9c with SMTP id j124-20020a636e82000000b004c7ac8f9e9cmr1279041pgc.92.1674216020418;
        Fri, 20 Jan 2023 04:00:20 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuA7i/4xacmcX/nrXqnXVi8YM4lDcno5f1Smra+9Z4O1PUfKjF3P4kqW2ZAmIok9gsJp0wsg7bIowNThOd+l3w=
X-Received: by 2002:a63:6e82:0:b0:4c7:ac8f:9e9c with SMTP id
 j124-20020a636e82000000b004c7ac8f9e9cmr1279039pgc.92.1674216020069; Fri, 20
 Jan 2023 04:00:20 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Fri, 20 Jan 2023 13:00:09 +0100
Message-ID: <CACT4oucMEZHtRcB_MSjvs-Sp289gp9x5LM35RiNqbMOC1iaixg@mail.gmail.com>
Subject: How to test one device pm ops
To:     linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

I'm trying to debug the suspend/resume operations of a NIC device. I
thought there should be an easy way to force this, but I haven't found
anything useful so far.

I've only found this:
https://www.kernel.org/doc/Documentation/power/basic-pm-debugging.txt

Which is not a bad starting point, but it can be a bit uncomfortable
if I have to do it many times when I'm only interested in a single
device. Is there any way to force resume/suspend, maybe from debugfs
or something like that?

Thanks in advance


--=20
=C3=8D=C3=B1igo Huguet

