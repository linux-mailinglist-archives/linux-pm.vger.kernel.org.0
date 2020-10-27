Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E3929C915
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 20:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755274AbgJ0TjA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 15:39:00 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36034 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504430AbgJ0TjA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 15:39:00 -0400
Received: by mail-lf1-f67.google.com with SMTP id h6so3890602lfj.3;
        Tue, 27 Oct 2020 12:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oSKJ52KX02pbIoZHYzF+rH9Iv+ZGut7jSb61YOY1u8k=;
        b=A5QlT5Ajrg5hX3qeNVkBillmBH/crjEuzDP8STRVYmqQ2x6onxY/hq07gpy6OFWjmN
         EjC/+CsbBUDSJRkmevpFr2r4akZGf9cbfA29AChzMkcEv/NGuqrNMJDULX2CgS0Voll+
         brSwpHEXhEbTAkLXle27QRaoh4+k/W17Mskq51bJ7t2xgAFkzw05yzRFyZxRC0xJVY2O
         40vSf6srqo6klIAYhkecoEgA9RjFHqTNYyHWJyEEqo2uD5snp2WESzI0WbGcXYEpXSd/
         QWieY/p8Ox6t1VPdLTNWuMzD7PMCfQhKIdukSW1XIOayP6i5W/42RESI3Ou8b3QH9Y4b
         bvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oSKJ52KX02pbIoZHYzF+rH9Iv+ZGut7jSb61YOY1u8k=;
        b=BfxHg98yQPLOtWdyR1YYvyY5Y1p5pB9gVtcdsI05ZDrmzcCR5bkmmVNJNZm0V9ful5
         LIdxjjhHhZAWy9ZrjTtDAvuXJCLb9CynutOe56tjcF9h8CSImJKmOdw9Cv5+Dy1CQG1Q
         eKKCykhLDR1SRt6NR9Axv3rJKC92ukjjVOuEdLdZIbg1T05qmjGn/8GqsI3DqyJsB/JE
         NAtkL0tjnKUMfPe/ky/aCqMTk6LRYH1exfcMLTSPnT/0Z/NtOH9kzk1Ty1DY41iX1lD1
         keNad6Q3zwZ3mWX7t8muuUwUeUHBvQcApJDqWU+gg7jUnoer1rWOqVUhn+ZczPbwCvXU
         R0BQ==
X-Gm-Message-State: AOAM530M72IHSdyKtKW++pwjxPZ9V7KAtsISeVZ1cDQgjb3dSM62/p+l
        92jmehGX3wx+S0FVa65d0SCWgD2H3YQ=
X-Google-Smtp-Source: ABdhPJxB1pU1rokYucpbd4/MZx1uZgD8u6sMCmHa6qc331GV6WUYPZB/6urRjr6Bn7o0SbCnnlBUNQ==
X-Received: by 2002:a19:834e:: with SMTP id f75mr1362840lfd.111.1603827537672;
        Tue, 27 Oct 2020 12:38:57 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.googlemail.com with ESMTPSA id c4sm272462lfm.294.2020.10.27.12.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 12:38:57 -0700 (PDT)
Subject: Re: [PATCH v6 32/52] memory: tegra20-emc: Continue probing if timings
 are missing in device-tree
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-33-digetx@gmail.com> <20201027135244.GM1822510@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0c306309-6f49-cbac-99ce-6d956d5e910c@gmail.com>
Date:   Tue, 27 Oct 2020 22:38:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201027135244.GM1822510@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

27.10.2020 16:52, Thierry Reding пишет:
> On Mon, Oct 26, 2020 at 01:17:15AM +0300, Dmitry Osipenko wrote:
>> EMC driver will become mandatory after turning it into interconnect
>> provider because interconnect users, like display controller driver, will
>> fail to probe using newer device-trees that have interconnect properties.
>> Thus make EMC driver to probe even if timings are missing in device-tree.
> 
> Does it really have to be mandatory? Sounds like that's going to make it
> unnecessarily complicated to merge all of this. Is it complicated to
> make interconnect support optional in consumer drivers?

Interconnect provider can't be optional if interconnect properties
present in a device-tree because drivers that use ICC path will get
-EPROBE_DEFER until ICC provider is registered.

Older device-trees don't have ICC properties, and thus, the ICC
users/consumers will get a dummy NULL ICC path in this case. I.e. ICC
core handles this for us.
