Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9356F64ECB9
	for <lists+linux-pm@lfdr.de>; Fri, 16 Dec 2022 15:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiLPOOQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Dec 2022 09:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiLPOOO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Dec 2022 09:14:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C312C13DCF
        for <linux-pm@vger.kernel.org>; Fri, 16 Dec 2022 06:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671200018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qG0RTQ0Lufr7P0nlKvEiW5+1t/mxLz6ftCQ96Os/jiU=;
        b=EbVZk1F57vHGjmpKBB8iyafBz3P2EgnvcrxclnJAgJnIDeVVia2MzXMuSst1gJx5Wy4Z8I
        IW4+a9da/7eM81xcRR5NBBVlxtovomBgBQYEHnHko1Izf15ao3Ttx9jBXMmFLIHoy+wmfJ
        shyef+MkiDLqlQ/ZXDoO63RRLKs98KQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-126-yA2T0PdIOom4jyCXiqAMDA-1; Fri, 16 Dec 2022 09:13:36 -0500
X-MC-Unique: yA2T0PdIOom4jyCXiqAMDA-1
Received: by mail-qk1-f199.google.com with SMTP id bi42-20020a05620a31aa00b006faaa1664b9so1881598qkb.8
        for <linux-pm@vger.kernel.org>; Fri, 16 Dec 2022 06:13:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qG0RTQ0Lufr7P0nlKvEiW5+1t/mxLz6ftCQ96Os/jiU=;
        b=W6jOs8TvGqawnN1DygNjV0iGycqrb2TuNukXSvY0F+YLpLD9xUcYsGghYGg6OOo56D
         CdLsRoh6Hp8Ikpupge7EUDP8cgK5gG0amcYOALy9FRXa2VIb7KiZvdo6tJuukC+SmlmG
         B5mdHBn8Rud2iu4tCQ2yZ+5upuJOw2BsdtutsonqCmnm9zMLakrQFGqMeQ5BL+MNi4ce
         KKrWjE9bR/htxvdPJAzEpCME5ewlla0Vt1+x95eCB8ptNJpW43TLk00zYqC7eq6lLTre
         65P57BqmqqCrf6K1GUlmh5ickZfKihEm+JrrneFlS/8TIk1J/LYDDTbL03E0p8XPjUsn
         xLfQ==
X-Gm-Message-State: ANoB5pnagN3vEPw6whItSN+teUCc9F4NB6fetDJB98p06hRQHrwwxXSp
        v/6sW1KF17qo5pmK0Pyrm6n7eN59q5YORnJPgR8SW5Kq/9tYGi3r9G/N06447j9sUiSu7IQVAjB
        gseV0d5pIyYa6HLK5A0M=
X-Received: by 2002:ac8:58ca:0:b0:3a8:a8e:c0e0 with SMTP id u10-20020ac858ca000000b003a80a8ec0e0mr51614589qta.8.1671200015743;
        Fri, 16 Dec 2022 06:13:35 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7K86tK0KkLvb028oLX6tmAK3Qiv95WtOD8YJePLr9hexYbI/9qlcvnBDrdI2fTfeY9TJBcxg==
X-Received: by 2002:ac8:58ca:0:b0:3a8:a8e:c0e0 with SMTP id u10-20020ac858ca000000b003a80a8ec0e0mr51614562qta.8.1671200015493;
        Fri, 16 Dec 2022 06:13:35 -0800 (PST)
Received: from fedora (modemcable149.19-202-24.mc.videotron.ca. [24.202.19.149])
        by smtp.gmail.com with ESMTPSA id r17-20020ac84251000000b003a50ef44a77sm1366328qtm.28.2022.12.16.06.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 06:13:34 -0800 (PST)
Date:   Fri, 16 Dec 2022 09:13:32 -0500
From:   Adrien Thierry <athierry@redhat.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-rt-users@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Eric Chanudet <echanude@redhat.com>,
        Brian Masney <bmasney@redhat.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH RFC] base: power: replace generic_pm_domain spinlock by
 raw spinlock
Message-ID: <Y5x9DEIsnLG7HoaQ@fedora>
References: <20220615203605.1068453-1-athierry@redhat.com>
 <cefad5f6-8aa4-acb8-231c-91170ec10bcf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cefad5f6-8aa4-acb8-231c-91170ec10bcf@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

> I also hit it now on v6.1 RT kernel. I see no more discussions happened
> here. Do you have any progress on your side for this issue?

Unfortunately I haven't investigated more since June. I was hoping RT
people could chime in.

Best,

Adrien

