Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEEF4145AD
	for <lists+linux-pm@lfdr.de>; Wed, 22 Sep 2021 11:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbhIVKBG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Sep 2021 06:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbhIVKBF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Sep 2021 06:01:05 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143EBC061756
        for <linux-pm@vger.kernel.org>; Wed, 22 Sep 2021 02:59:36 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t18so5244118wrb.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Sep 2021 02:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=wVE4R8C/cgi96odywCvgg2C5/wXSs+GANvotR7N/uR8=;
        b=vIPxreyzdq2HXWtttAy9AphQhkLfK4uZFOBtQWVuzCvfaQaGlSrWfzT6n9N5Pu1YSP
         Zd7a3y3A3IGxmjlzxIkCpCeIsw7Eq2kpQg0CM1Krp8AgDBTqUiw/OOZHxxjsfBXm45eD
         Z+8Rfo5CrZawF+BOlX+NfapdsAaLj0Oe1ia7qEIttA25RdJzWdG3KBcfsqExfqTlQwv4
         iJ/MRD9a2Cydy0LF6BqUeb4De6ZYucwR8khVHCo2vaOpzSERlEr6499w836Fzxg9YV0v
         Z2P65RxpYuC5rQTq993ssJ0nu7MsFJde5XE4XUrQ7eo75Nhihh4ApWLz1DxRN3J1q2ko
         Nliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=wVE4R8C/cgi96odywCvgg2C5/wXSs+GANvotR7N/uR8=;
        b=g5NVStKJXmQkNoXihPK+FdUfhSa0A9vZqhpYwdzEM+md8xl0kfpL3YBlLT3lVnmIlg
         CR3vf8uPc2K028nR0I9J8VF7IClTYZ7IxxkJ+QClt025vl0sle1eZusP6U1xWYufDT0V
         WwXDBJgiGFZ1xc9KIlkwmbMEkBLPofv42JU7Cl8K7b3CyB+qPNfv2WbKMm/rlzkf82wa
         b0MbjvXeehwXOuRRRmRiM5VRw+AzTTPZsIogrvqu08RPwWmEA0KMrVKR/H3t1iVhxYkF
         3BIilCzBkVKiLcsrgf1HHa+/gRPWotbqL0NaUzvbUmb8XxuRuW2x/gg6i0RZhhjkw7Xk
         Bm+Q==
X-Gm-Message-State: AOAM531qNDBqMGitF48/AZm2ayWR0OIrB8Hyhw/sf+Fc9Gxaa/kyLHRZ
        hrk5ASOPW1MPxedAqXrp0q8psEwheHKtzQ==
X-Google-Smtp-Source: ABdhPJz19tnF6GcYxfblJoxm65IbrNZux22yI1JyMaQb0d5aKNU5H+vy7Ql/aGtLMcNCedy86Mv2Ig==
X-Received: by 2002:a05:600c:19cb:: with SMTP id u11mr7114787wmq.185.1632304774391;
        Wed, 22 Sep 2021 02:59:34 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:4f54:2a4:2d47:4592? ([2a01:e34:ed2f:f020:4f54:2a4:2d47:4592])
        by smtp.googlemail.com with ESMTPSA id s2sm1631915wrn.77.2021.09.22.02.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 02:59:33 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFD] Remove the userspace governor and the cooling device set state
 sysfs entry
To:     Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
Message-ID: <d46b5007-428b-5f31-52d9-a964cc60ad92@linaro.org>
Date:   Wed, 22 Sep 2021 11:59:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi,

the userspace governor is sending temperature when polling is active and
trip point crossed events. Nothing else.

In the other side, the cooling device have their cooling device
set_cur_state read-writable all the time.

The thermal framework is wrongly used by userspace as a power capping
framework by acting on the cooling device opaque state. This one then
competes with the in-kernel governor decision.

As the new netlink thermal notification is able to provide the same
information than the userspace governor.

I propose to remove the userspace governor and the cur_state entry in
the sysfs exported file.

The DTPM framework is the right framework to do power capping and
moreover it deals with the aggregation via the dev pm qos.

Does it make sense ?

  -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
