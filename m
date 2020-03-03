Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2E7177167
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 09:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgCCIn6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 03:43:58 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40610 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbgCCIn5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2020 03:43:57 -0500
Received: by mail-wr1-f65.google.com with SMTP id r17so3223256wrj.7
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2020 00:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=yvGUbo1dfhbwTbh96YBjm+vOHC+xmC7MRUhhdcNamr0=;
        b=KueoG3CH8d1TILJ3jEseAooEkY/vqCzu5vVfybY/sidTv3lRB7+bx+mjB5w2ewajdY
         cY8h1RYGKivEhz4QZtczAVzTeVu+P8LmMF9AqbQANAoUbkt6AxMrzXQC84mvDEoYG5Sn
         R3/Gc+FFqRUZEb3iQbSEWNuvqpxv78iVNG59hxMWr4q4lvnvaotMkLy1YuQ2jQaT8inW
         DlTbYgGFp2Duo1qHw1IXajEDprPuJtugfSxcbbaYU6xMgfl1u96wPJPHjqzrC22V/2m3
         3oLB9yd31KEWxmtyXhtjLTwMXgnlxsNdCudYoVBzxcZeNeQEAJj495TfgrRNYY2e6jwN
         lUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=yvGUbo1dfhbwTbh96YBjm+vOHC+xmC7MRUhhdcNamr0=;
        b=dAMFt8O2wSUETK+IU9DhPjxS/Ff2JU1km5Q/gSbAw0Rb6b+8KcfAGHZFsiog3z87sx
         cK/WfRlTKEBb515opdfNOvAMT2rFQruO4KzFdN27Vf1RYF4y++Xf+Zivqp2MTm21b5mk
         VneYYcE+kL9t0eIxk9aPzGgua4GumgG5PNiTq4WBh8C5fdmzpACqsAHi1mnZgM0g3vOp
         swr1lqfse2tuczRmXyZ3LjCunF8bdi5QMNddyIYFc5wXsRNq4dW4N3c2CTmSoIWaVgA2
         fgTbyG9F2axWIgNRx8mwF9zbm/Wte9SrnvYDFpImgZ3s7+QdlGKMMaIhL1oreoBYewzt
         P7Og==
X-Gm-Message-State: ANhLgQ3/XYaLmgy6f1HpZuSXGpRA7t0vuCfgWIpp5NO5kr4itglW/0vp
        kI4F62XFUxDZ/B3DP3Bn5iShxg==
X-Google-Smtp-Source: ADFU+vth77irrYVpMCLL+lMOH+om3PsHUPjCNnAr+ba1VOLlWJv+R/5L/2HoCPBEenVfN9Fm/OsO5w==
X-Received: by 2002:adf:fa05:: with SMTP id m5mr4425101wrr.352.1583225034157;
        Tue, 03 Mar 2020 00:43:54 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id p15sm2720213wma.40.2020.03.03.00.43.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Mar 2020 00:43:53 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Rob Herring <robh@kernel.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     linux-amlogic@lists.infradead.org,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        SoC Team <soc@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: power: Fix dt_binding_check error
In-Reply-To: <20200302201554.GA22028@bogus>
References: <1583164448-83438-1-git-send-email-jianxin.pan@amlogic.com> <20200302201554.GA22028@bogus>
Date:   Tue, 03 Mar 2020 09:43:52 +0100
Message-ID: <7h5zflrfp3.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rob Herring <robh@kernel.org> writes:

> On Mon, 2 Mar 2020 23:54:08 +0800, Jianxin Pan wrote:
>> Missing ';' in the end of secure-monitor example node.
>> 
>> Fixes: 165b5fb294e8 ("dt-bindings: power: add Amlogic secure power domains bindings")
>> Reported-by: Rob Herring <robh+dt@kernel.org>
>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>> ---
>>  Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
>
> If a tag was not added on purpose, please state why and what changed.

I've (re)added these tags:

  Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
  Acked-by: Rob Herring <robh@kernel.org>

when applying this time.

Jianxin, please collect the tags in the future and add when you send
follow-up versions.

Thanks,

Kevin
