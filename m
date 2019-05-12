Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4DA1ACA3
	for <lists+linux-pm@lfdr.de>; Sun, 12 May 2019 16:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfELOeH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 May 2019 10:34:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53661 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfELOeH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 May 2019 10:34:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id 198so11412647wme.3;
        Sun, 12 May 2019 07:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=opR4X5SmjYgiPNH3JawKfnbS9NWBfn0uzbl47S80FYI=;
        b=XFbZDUmuQrh5sCUaUDLal6ofM+5BJCfbJaQQvz5AlbQFiBVoTsmkmtIQFHIc+CWX9e
         bzLjZNsrDX/8oz6O8xJOKBOLIshKD4UDrIPDE6KUtRA6+NzcBhFfFg12e7rt/fsRu4Xt
         Ipf0lkDRpBjzT5ek3NE32Cy7Y2qwpRiYA4hTA/QZd0k122xc8/LOqtJsTUlSQS1TYTuo
         SCcR/VCM3X8cPdYxjA8UMgq3YYxTZUMySQQm8pmShJpc1UepGQXfDRSCTlM/F1m4N6EN
         6lXFw6adIcICb18GJxluDnjRY/cv5zkitLpxJ5oJjoH0GZ53Ly28QUMxcQed/oSL0s2e
         G3Ug==
X-Gm-Message-State: APjAAAVWEdRJVuxN2K75oW5+L4amYrXDnZarBgV/pjE7imrJf/urmFZG
        EseYVGge0xH5Rv46xK+cO/g=
X-Google-Smtp-Source: APXvYqyUtZ/+lZiGS4U9OG78QMCAF2idckf7O3CD4JvxAXJKPTmOWf18PhP4AKCdIKLdW1SZ9cJTUg==
X-Received: by 2002:a1c:c7c8:: with SMTP id x191mr4359561wmf.126.1557671645856;
        Sun, 12 May 2019 07:34:05 -0700 (PDT)
Received: from [192.168.81.52] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e12sm1980146wrs.8.2019.05.12.07.34.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 07:34:05 -0700 (PDT)
Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
To:     Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>
Cc:     linux-pm <linux-pm@vger.kernel.org>,
        Rafael Wysocki <rafael@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Kai Heng Feng <kai.heng.feng@canonical.com>
References: <20190510212937.11661-1-keith.busch@intel.com>
 <20190511072258.GB14764@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <efc9d481-d2cf-93bc-b640-849892421941@grimberg.me>
Date:   Sun, 12 May 2019 07:34:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190511072258.GB14764@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


>> +int nvme_set_power(struct nvme_ctrl *ctrl, unsigned ps)
>> +{
>> +	return nvme_set_features(ctrl, NVME_FEAT_POWER_MGMT, ps, NULL, 0, NULL);
>> +}
>> +EXPORT_SYMBOL_GPL(nvme_set_power);
>> +
>> +int nvme_get_power(struct nvme_ctrl *ctrl, u32 *result)
>> +{
>> +	struct nvme_command c;
>> +	union nvme_result res;
>> +	int ret;
>> +
>> +	if (!result)
>> +		return -EINVAL;
>> +
>> +	memset(&c, 0, sizeof(c));
>> +	c.features.opcode = nvme_admin_get_features;
>> +	c.features.fid = cpu_to_le32(NVME_FEAT_POWER_MGMT);
>> +
>> +	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &c, &res,
>> +			NULL, 0, 0, NVME_QID_ANY, 0, 0, false);
>> +	if (ret >= 0)
>> +		*result = le32_to_cpu(res.u32);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(nvme_get_power);
> 
> At this point I'd rather see those in the PCIe driver.  While the
> power state feature is generic in the spec I don't see it actually
> being used anytime anywhere else any time soon.
> 
> But maybe we can add a nvme_get_features helper ala nvme_set_features
> in the core to avoid a little boilerplate code for the future?

+1 on this comment.
