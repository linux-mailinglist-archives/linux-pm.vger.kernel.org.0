Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A4D7BF3E2
	for <lists+linux-pm@lfdr.de>; Tue, 10 Oct 2023 09:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442399AbjJJHPB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Oct 2023 03:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379430AbjJJHPA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2023 03:15:00 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFA39E
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2023 00:14:58 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-690bd59322dso3912550b3a.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2023 00:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696922098; x=1697526898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=REm2zqg1Yqfh1vOVaadZ+RhgYDjuMh+lGEwKArpLfM4=;
        b=DkbEw6pAaR6GxOwIZPN5yJ9s09i2T84xdgNoDlwLkckqs2UhUmt7VhaWk+4V840HK/
         z7eNUGMsaHFn1fFJohfXgX0Tn0la0v+R3JmTNhKt1D0C6MCM4iTU6JeUOQYcJNHEkGUq
         NjvfVnQngrPfVfyCi1DLCFy0ktCJk48AR7kVoA1OMCbrDARsdZb7PrsMCiVP44lsLHLD
         0JWNX/ZJiKvIUPC2sc9hLW+yWqw8+gq23C6muBx4m9zPg+RghTe5IKv50XUnXmRSbYZp
         JpFkkeLJGKZ6WNMxDmh7ZbmIcNfBppP2D3tulH6kiGoHl8+JpDsWYplpXfzYccuv3gYz
         2aUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696922098; x=1697526898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REm2zqg1Yqfh1vOVaadZ+RhgYDjuMh+lGEwKArpLfM4=;
        b=trYL/RVn9PxMejXU6j0EHsHVsmwI+CI+Jha/7KzTFLbTsIbSPf/4Ho/Ome4h4hMv+d
         hF1hoxE7omKgBB4ElQNnfGbmTd4PZO/wY6NGW6qYpny0TIHNyJmPsuCryH5k9YpBFe//
         UGvActO9w5NK6WJ6uANACCYaRYmYDAqZiFYMh8BRsmYOFJ7dlEHuBszb32Hbe18g74MK
         yNm1fvdt9jPAsb/1FK6PfH00N6zQX7m7Q5MZyLzC9zf1sQlym8p2sCSus7jeyr3xbpGd
         hZ+LrpvZUDw3ckQJJ3cySM1zeSn7k3fO2LiYqfaZxhj4Hr2rPRZx1FKZTEGAhM5W+P0Z
         mXeA==
X-Gm-Message-State: AOJu0YyRo5DgYzr7/47myQwbZ+ymzZF3GUk3VEn1KbNW+hH1wUz6UXoP
        qRBb5I39A1IDWZjKSs3zWPY5eA==
X-Google-Smtp-Source: AGHT+IENnvdaKTVZ5RG5IrW2a7uivx0fUemlOha+KjhdmWG1K6IFuThbxfhfA3BeEDs1er7GXht8OQ==
X-Received: by 2002:a05:6a00:2e10:b0:68e:41e9:10be with SMTP id fc16-20020a056a002e1000b0068e41e910bemr18547606pfb.20.1696922098204;
        Tue, 10 Oct 2023 00:14:58 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id e5-20020aa78c45000000b00692acfc4b3csm7392779pfd.136.2023.10.10.00.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 00:14:57 -0700 (PDT)
Date:   Tue, 10 Oct 2023 12:44:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Robert Marko <robimarko@gmail.com>, ilia.lin@kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, rafael@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 2/4] dt-bindings: opp: opp-v2-kryo-cpu: Document named
 opp-microvolt property
Message-ID: <20231010071455.2jgo3e772aw5f7fa@vireshk-i7>
References: <20230930102218.229613-1-robimarko@gmail.com>
 <20230930102218.229613-2-robimarko@gmail.com>
 <CAA8EJpoTsHhAVT3b84BC7Brvh=AUOUYSB_Z+_R-9OQ-u9BpH8A@mail.gmail.com>
 <651b15ae.df0a0220.c5688.0c40@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <651b15ae.df0a0220.c5688.0c40@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02-10-23, 21:10, Christian Marangi wrote:
> On Mon, Oct 02, 2023 at 10:07:44PM +0300, Dmitry Baryshkov wrote:
> > On Sat, 30 Sept 2023 at 13:22, Robert Marko <robimarko@gmail.com> wrote:
> > I suppose that simple 'true' schema should be enough since this is
> > already mostly described in opp/opp-v2-base.yaml
> >
> 
> Mhhh an example of the following implementation?

Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml

-- 
viresh
