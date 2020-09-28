Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3CC27B406
	for <lists+linux-pm@lfdr.de>; Mon, 28 Sep 2020 20:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgI1SD6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Sep 2020 14:03:58 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46992 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgI1SD6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Sep 2020 14:03:58 -0400
Received: by mail-oi1-f194.google.com with SMTP id u126so2298015oif.13;
        Mon, 28 Sep 2020 11:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b47m6kGoNWc4/uwIrttlIVNkgPngBrRz1iBKHy3w57s=;
        b=WpPAkT0iFvpxkxu0DV3jrp8TxkNZa71Pb53f92w6BXBnxH85Fm81PWIo8smqBHOkNq
         0o6lWNyuZGRlgyqEPwOKVk95Rt/wYbvVa6XoDDrCo/ZyhKOMJnPJfbsHq5LDOXrONgv0
         xA+Ni70wmsh6DCSVULxFjPi9K3w1WMqFREie5qNLoagU2S/AgF8D4J1ZKqYShl5dxC9T
         fy1USMQmDNBQaww5Pj2Oe60NF7jGclRK/Q1AFA9AcbS2OsJriyrwrVhlmFE6Gzx/KeuV
         EzRZ+sMhQuY/l80vX+yDjvQuoP1W/KemkQ2kJeWtsIvpjYkrfYZLuYCHMtBQpR7s/6yI
         JrGQ==
X-Gm-Message-State: AOAM532yXfmK+NWwtKGbPVmPTzbyjDMhBDLwjqmEnLByCFkH8EsKdrP3
        wiPFpaCe8/IbMPdQFYnfhQ==
X-Google-Smtp-Source: ABdhPJwUlNfZsjTADK9YsUbvwa2mVcVcPNzQHs7Phaize49QJOgmDZPGHTv6z/TvTWN15QcvW4twOQ==
X-Received: by 2002:aca:4fd5:: with SMTP id d204mr83530oib.58.1601316236901;
        Mon, 28 Sep 2020 11:03:56 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p8sm2261067oot.29.2020.09.28.11.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 11:03:56 -0700 (PDT)
Received: (nullmailer pid 2999675 invoked by uid 1000);
        Mon, 28 Sep 2020 18:03:55 -0000
Date:   Mon, 28 Sep 2020 13:03:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 2/2] dt-bindings: devfreq: Document L2 Krait CPU Cache
 devfreq driver
Message-ID: <20200928180355.GA2999374@bogus>
References: <20200927160515.6480-1-ansuelsmth@gmail.com>
 <20200927160515.6480-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200927160515.6480-2-ansuelsmth@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 27 Sep 2020 18:05:13 +0200, Ansuel Smith wrote:
> Document dedicated L2 Krait CPU Cache devfreq scaling driver.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/devfreq/krait-cache-devfreq.yaml | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/krait-cache-devfreq.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

./Documentation/devicetree/bindings/devfreq/krait-cache-devfreq.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/devfreq/krait-cache-devfreq.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/devfreq/krait-cache-devfreq.example.dt.yaml: qcom-krait-cache: clocks:0:1: missing phandle tag in 4
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/devfreq/krait-cache-devfreq.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/devfreq/krait-cache-devfreq.example.dt.yaml: qcom-krait-cache: clocks:0: [4294967295, 4] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/devfreq/krait-cache-devfreq.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/devfreq/krait-cache-devfreq.example.dt.yaml: qcom-krait-cache: 'voltage-tolerance' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/devfreq/krait-cache-devfreq.yaml


See https://patchwork.ozlabs.org/patch/1372099

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

