Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A594008E7
	for <lists+linux-pm@lfdr.de>; Sat,  4 Sep 2021 03:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241687AbhIDBJC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Sep 2021 21:09:02 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:36420 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233140AbhIDBJC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Sep 2021 21:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1630717681; x=1662253681;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=7xxHeqae1Sf4qltUF2sS35BhNYC+euCldDo7xBlypfs=;
  b=sFrG4TPlAHWoeYA3TcitTCN/7KX5BliePCAyDNvBb9n6c+mBStWetES4
   koO4OgkuKew2s6UGiCvHZrLI8uP1J9UVKZgSBsHQM0HnPyE80lYTcCtXm
   PB2EopeO/U96G4XtEm+AkYAnEXD4piH3BBgl4Bz8hn1VnxItllw1iacGO
   c=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 03 Sep 2021 18:08:01 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 18:08:01 -0700
Received: from [10.46.160.247] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7; Fri, 3 Sep 2021
 18:07:58 -0700
Subject: Re: [PATCH] thermal: Fix a NULL pointer dereference
To:     Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Amit Kucheria" <amitk@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, David Collins <quic_collinsd@quicinc.com>
References: <1630715659-5058-1-git-send-email-quic_subbaram@quicinc.com>
From:   David Collins <quic_collinsd@quicinc.com>
Message-ID: <fe7ba5a5-d39a-dd0a-5cd3-f80ff163162a@quicinc.com>
Date:   Fri, 3 Sep 2021 18:07:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1630715659-5058-1-git-send-email-quic_subbaram@quicinc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/3/21 5:34 PM, Subbaraman Narayanamurthy wrote:
> of_parse_thermal_zones() parses the thermal-zones node and registers a
> thermal_zone device for each subnode. However, if a thermal zone is
> consuming a thermal sensor and that thermal sensor device hasn't probed
> yet, an attempt to set trip_point_*_temp for that thermal zone device
> can cause a NULL pointer dereference. Fix it.
> 
>   console:/sys/class/thermal/thermal_zone87 # echo 120000 > trip_point_0_temp
>   ...
>   Unable to handle kernel NULL pointer dereference at virtual address 0000000000000020
>   ...
>   Call trace:
>    of_thermal_set_trip_temp+0x40/0xc4
>    trip_point_temp_store+0xc0/0x1dc
>    dev_attr_store+0x38/0x88
>    sysfs_kf_write+0x64/0xc0
>    kernfs_fop_write_iter+0x108/0x1d0
>    vfs_write+0x2f4/0x368
>    ksys_write+0x7c/0xec
>    __arm64_sys_write+0x20/0x30
>    el0_svc_common.llvm.7279915941325364641+0xbc/0x1bc
>    do_el0_svc+0x28/0xa0
>    el0_svc+0x14/0x24
>    el0_sync_handler+0x88/0xec
>    el0_sync+0x1c0/0x200
> 
> Cc: stable@vger.kernel.org
> Suggested-by: David Collins <quic_collinsd@quicinc.com>
> Signed-off-by: Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>
> ---
>   drivers/thermal/thermal_of.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 6379f26..ba53252 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -301,7 +301,7 @@ static int of_thermal_set_trip_temp(struct thermal_zone_device *tz, int trip,
>   	if (trip >= data->ntrips || trip < 0)
>   		return -EDOM;
>   
> -	if (data->ops->set_trip_temp) {
> +	if (data->ops && data->ops->set_trip_temp) {
>   		int ret;
>   
>   		ret = data->ops->set_trip_temp(data->sensor_data, trip, temp);
> 

It looks like the same kind of data->ops null pointer dereference issue is 
present in three other functions within this file: of_thermal_get_temp(), 
of_thermal_set_emul_temp(), and of_thermal_get_trend().  Should those be 
fixed along with of_thermal_set_trip_temp() in a single patch?

Thanks,
David
